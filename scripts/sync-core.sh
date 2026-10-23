#!/usr/bin/env bash
# Inject plugins/beyond-pa/core/CORE.md into every skills/*/SKILL.md between the core markers.
# Idempotent: running twice produces no diff. Run from anywhere.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN="$ROOT/plugins/beyond-pa"
CORE="$PLUGIN/core/CORE.md"
[ -f "$CORE" ] || { echo "ERROR: $CORE missing" >&2; exit 1; }
python3 - "$CORE" "$PLUGIN"/skills/*/SKILL.md <<'PY'
import sys, re, pathlib
core = pathlib.Path(sys.argv[1]).read_text(encoding="utf-8").rstrip("\n")
START = "<!-- core:start (generated from core/CORE.md, do not edit here) -->"
END = "<!-- core:end -->"
block = f"{START}\n{core}\n{END}"
changed = 0
for p in sys.argv[2:]:
    path = pathlib.Path(p)
    text = path.read_text(encoding="utf-8")
    if START in text and END in text:
        new = re.sub(re.escape(START) + r".*?" + re.escape(END), lambda m: block, text, count=1, flags=re.S)
    else:
        m = re.search(r"^# .+$", text, flags=re.M)
        if not m:
            print(f"ERROR: no H1 in {p}", file=sys.stderr); sys.exit(1)
        new = text[:m.end()] + "\n\n" + block + text[m.end():]
    if new != text:
        path.write_text(new, encoding="utf-8"); changed += 1
print(f"sync-core: {changed} file(s) updated, {len(sys.argv)-2} checked")
PY
