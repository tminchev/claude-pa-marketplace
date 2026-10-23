---
name: inbox-digest
description: Weekly summary of what the inbox organizer filed where, what it was unsure about, and a chance for the person to correct it. Use when the person says "what did you file", "inbox digest", "what went to Review", "show me what you moved", "correct a rule", or when a scheduled task names inbox-digest.
---

# Inbox digest

Once a week, show the person what the inbox organizer did, surface anything uncertain, and turn their corrections into rules. This is how the system learns without ever guessing.

## Ground rules

**Mode.** *Unattended* if started from a scheduled task naming this skill: produce the digest and email it. *Interactive* otherwise: show the digest in chat and process corrections on the spot.

**Provider.** Gmail tools: Google mode. Microsoft 365 tools: Microsoft mode. Neither: stop and name the missing connector.

**Workspace.** `Claude Assistant` folder. Read `preferences.md`, `inbox-rules.md`, and `journal/inbox-*.md` for the last seven days. If `inbox-rules.md` is missing or not approved, say the inbox organizer has not been set up and stop.

**Never** change rules, move mail, or send to anyone other than `delivery_email` in unattended mode. In interactive mode, change rules only after the person confirms each change.

## Steps

1. **Totals.** From the journal entries: how many messages were filed, per category, and how many runs happened. If a run reported an error, say so first.
2. **Review items.** List what is currently in the Review label or folder, grouped by sender, with count and a one-line reason you could not place it (no matching rule, new sender, looks like a real conversation). Cap at 25 groups; say how many more there are.
3. **Suggestions.** For each Review group with three or more messages, propose a category in one line, phrased as a question: "Receipts from parcelco.com (6): file under Shop receipts?"
4. **Suggest mode check.** If `suggest_mode: on` and `suggest_mode_until` has passed, ask: "The first week is over. Shall I start moving filed mail out of your inbox from now on?"
5. **Numbered questions.** (Normal chat has no buttons, so numbering is how the person answers quickly.) End with a numbered list of every question asked, so the person can reply "1 yes, 2 no, 3 Newsletters".

## Unattended output

One email to `delivery_email`, subject `Inbox digest, week of <Monday's date>`, in this order: one-line summary, filed counts per category, Review groups with suggestions, suggest-mode question if due, numbered questions. Under 400 words. End with: "Reply here, or tell me in a chat, and I'll update the rules."

## Interactive follow-up

When the person answers:
- A confirmed suggestion becomes a new row in the `Rules` table of `inbox-rules.md` and a line in the `Corrections log`. Apply it to the matching Review items now (label and archive, or move) and say how many moved.
- A "leave it" answer adds the sender to never-touch, or simply removes it from Review back to the inbox, whichever they mean; ask if unclear.
- Ending suggest mode sets `suggest_mode: off` in `preferences.md`; tell them the next organizer run will start moving mail.
- Update `last_updated` in `inbox-rules.md`.
