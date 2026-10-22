---
name: capture
description: Quickly records tasks, reminders, notes and facts about people into the person's workspace. Use when the person says "remind me", "add a task", "note that", "remember that", "I met", "write down", "to-do", "put on my list", "mark done", "what's on my list", or shares a fact about a person they work with.
---

# Capture

Take what the person says and put it in the right file, then confirm in one line. This is meant to feel instant.

## Ground rules

**Mode.** Interactive. If started from a scheduled task, stop.

**Workspace.** `Claude Assistant` folder in Drive or OneDrive. Files: `tasks.md`, `people.md`, `notes/<yyyy-mm>.md`. Read before writing, append rather than rewrite, and keep the existing headings. If the workspace is missing, point to "set me up". If writes fail (Microsoft mode without write actions), keep the item in the conversation and say the folder is read-only right now.

**Never** send mail, change the calendar, or touch any other file.

## Routing

- **Task**: an action the person must do, often with "remind me", "I need to", "to-do", "by Friday". Goes to `tasks.md` under `## Open` as `- [ ] <task> (due: <date or none>) (added: <today>)`. Parse relative dates ("Friday", "next week", "end of month") against today in the person's time zone and write the absolute date. "Remind me at 3pm tomorrow" is a task with a due date and time; say that reminders arrive through the morning brief and the inbox triage, not as a popup, unless they also want a one-off scheduled task, which they can create under Scheduled.
- **Person**: a fact about someone ("I met Anna from Acme, she runs procurement", "Jon prefers calls to email"). Goes to `people.md`: update the existing line if the person exists, otherwise add under `## Regular`. If they say the person is important or must always reach them, add under `## VIP` and mention that the inbox organizer treats VIPs as never-filed.
- **Note**: anything else ("note that the supplier quoted 4 weeks", a thought, a decision). Goes to `notes/<yyyy-mm>.md` as `- <today> — <note>`. If the note is about a decision, prefix with `Decision:`.
- **Done**: "mark X done", "I finished X": move the matching line from Open to `## Done` with the date. If several match, show them and ask.
- **List**: "what's on my list", "what's open": show Open tasks grouped by overdue, due this week, no date. Offer nothing else unless asked.

A single message can contain more than one item; route each.

## Confirmation

One line, naming the file in plain words: "Added to your tasks, due Friday 24 Oct." / "Noted Anna under people, marked as VIP." / "Saved to this month's notes." No preamble, no restating the whole item.
