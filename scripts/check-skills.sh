#!/usr/bin/env bash
# Conformance gate for plugins/beyond-pa/skills/*/SKILL.md. Four checks, each with a negative control.
#   1. description strict-parses as YAML to the same text as the raw file, and is <= 1024 chars
#      (an unquoted '#' or 'key: value' silently truncates a description and the skill never fires)
#   2. exactly one core block, byte-identical to core/rules.md
#   3. file <= 200 lines
#   4. no em dash (U+2014) or en dash (U+2013)
#   5. folder name starts with pa- and equals the name field (no collisions with built-in skills)
#   6. no retired term survives in a skill body (the RETIRED list grows whenever a concept is removed)
#   5. folder name starts with pa- and equals the name field (no collisions with built-in skills)
#   6. no retired term survives in a skill body (the RETIRED list grows whenever a concept is removed)
# Exit 1 on any failure. Run from anywhere.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN="$ROOT/plugins/beyond-pa"
python3 - "$PLUGIN" <<'PY'
import sys, re, pathlib, tempfile, os
plugin = pathlib.Path(sys.argv[1])
core = (plugin / "core" / "rules.md").read_text(encoding="utf-8").rstrip("\n")
START = "<!-- core:start (generated from core/rules.md, do not edit here) -->"
END = "<!-- core:end -->"
fails = []
RETIRED = ["delivery_email", "by email", "cron", "Code tab", "reply with a number", "/schedule", "or send?", "sends only on", "send one email", "without explicit confirmation", "tap Schedule", "one tap", "tap to confirm"]

def yaml_scalar(fm_text):
    """Return the description as a strict YAML parser would read it. Supports plain scalars,
    quoted scalars, and '>-' folded block scalars. Comments start at ' #'."""
    m = re.search(r"^description:[ \t]*(.*)$", fm_text, flags=re.M)
    if not m:
        return None
    first = m.group(1)
    if first.strip() in (">-", ">", "|-", "|"):
        lines = fm_text[m.end():].split("\n")
        body = []
        for ln in lines[1:] if lines and lines[0] == "" else lines:
            if ln.startswith((" ", "\t")):
                body.append(ln.strip())
            elif ln.strip() == "":
                body.append("")
            else:
                break
        return " ".join(x for x in body if x != "")
    v = first.strip()
    if v[:1] in ("'", '"'):
        q = v[0]
        end = v.find(q, 1)
        return v[1:end] if end > 0 else None
    # plain scalar: a ' #' starts a comment; ': ' makes it a mapping, i.e. unparseable as a string
    if ": " in v or v.endswith(":"):
        return None
    return v.split(" #")[0].rstrip()

def raw_description(fm_text):
    m = re.search(r"^description:[ \t]*(.*)$", fm_text, flags=re.M)
    first = m.group(1)
    if first.strip() in (">-", ">", "|-", "|"):
        lines = fm_text[m.end():].split("\n")
        body = [ln.strip() for ln in lines[1:] if ln.startswith((" ", "\t"))]
        return " ".join(body)
    return first.strip().strip("'\"")

def check_file(path, text):
    problems = []
    fm = re.match(r"^---\n(.*?)\n---\n", text, flags=re.S)
    if not fm:
        return ["no frontmatter"]
    fmt = fm.group(1)
    parsed = yaml_scalar(fmt)
    raw = raw_description(fmt)
    if parsed is None:
        problems.append("description does not strict-parse as a string")
    elif " ".join(parsed.split()) != " ".join(raw.split()):
        problems.append(f"description silently truncates (parsed {len(parsed)} chars, raw {len(raw)})")
    if raw and len(raw) > 1024:
        problems.append(f"description {len(raw)} chars, over 1024")
    if text.count(START) != 1 or text.count(END) != 1:
        problems.append("core block missing or duplicated")
    else:
        inner = text.split(START, 1)[1].split(END, 1)[0].strip("\n")
        if inner != core:
            problems.append("core block differs from core/rules.md (run scripts/sync-core.sh)")
    n = text.count("\n") + (0 if text.endswith("\n") else 1)
    if n > 200:
        problems.append(f"{n} lines, over 200")
    if "—" in text or "–" in text:
        problems.append("contains an em or en dash")
    # retired concepts: once removed from the design they must not survive anywhere in a skill
    body = text.split(END, 1)[1] if END in text else text
    for term in RETIRED:
        if term.lower() in body.lower():
            problems.append(f"retired term present: {term!r}")
    nm = re.search(r"^name:[ \t]*(.+)$", fmt, flags=re.M)
    folder = path.parent.name if hasattr(path, "parent") else None
    if nm and folder and nm.group(1).strip() != folder:
        problems.append(f"name '{nm.group(1).strip()}' does not match folder '{folder}'")
    if folder and not folder.startswith("pa-"):
        problems.append(f"folder '{folder}' lacks the pa- prefix")
    return problems

for p in sorted(plugin.glob("skills/*/SKILL.md")):
    probs = check_file(p, p.read_text(encoding="utf-8"))
    for pr in probs:
        fails.append(f"{p.parent.name}: {pr}")

# negative controls: each must FAIL, or the gate is not checking anything
block = f"{START}\n{core}\n{END}"
good = f"---\nname: pa-t\ndescription: >-\n  Does a thing when the person says \"go\".\n---\n\n# t\n\n{block}\n\nbody\n"
controls = {
    "truncated description": good.replace('description: >-\n  Does a thing when the person says "go".', 'description: Does a thing #tagged'),
    "key-colon description": good.replace('description: >-\n  Does a thing when the person says "go".', 'description: Use for STRUCTURAL work only: scaffolds'),
    "missing core": good.replace(block, "no block here"),
    "stale core": good.replace(core, core + "\nextra line"),
    "over 200 lines": good + "\n".join(["x"] * 200) + "\n",
    "em dash": good.replace("body", "body — dash"),
}
class _P:
    def __init__(self, n): self.parent = type("D", (), {"name": n})()
if check_file(_P("pa-t"), good):
    fails.append(f"control: the good fixture was rejected: {check_file(_P('pa-t'), good)}")
for name, fixture in controls.items():
    holder = _P("t") if name == "missing pa- prefix" else _P("pa-t")
    if not check_file(holder, fixture):
        fails.append(f"control: '{name}' fixture was accepted; the gate is broken")

if fails:
    print("check-skills: FAIL"); [print("  " + f) for f in fails]; sys.exit(1)
print(f"check-skills: OK ({len(list(plugin.glob('skills/*/SKILL.md')))} skills, 8 negative controls held)")
PY
