---
name: meeting-prep
description: Prepares the person for upcoming meetings: who is attending, recent email with them, open items, agenda and talking points. Use when the person says "prep me for", "prepare me for my meeting", "tomorrow's meetings", "who am I meeting", "brief me on this call", "what do I need for the 3pm", or when a scheduled task names meeting-prep.
---

# Meeting prep

One short section per meeting so the person walks in knowing who, why and what to say.

## Ground rules

**Mode.** *Unattended* if started from a scheduled task naming this skill: window is the next working day, output is one email. *Interactive* otherwise: window is what the person asks for, default the rest of today and tomorrow.

**Provider.** Google Calendar and Gmail tools: Google mode. Microsoft 365 tools: Microsoft mode. Neither: stop and name the missing connector.

**Workspace.** `Claude Assistant` folder. Read `profile.md`, `preferences.md` (meeting-prep section, especially `scope`), `people.md`, `tasks.md`, and `notes/` for anything mentioning the attendees or the topic.

**Never** change, accept or decline calendar events, send mail, or email anyone except `delivery_email`.

## For each meeting in scope

Skip all-day events, events the person declined, and personal calendar entries unless asked. If `scope: external only`, skip meetings where every attendee shares the person's email domain.

1. **Header**: time, duration, title, location or link, organiser.
2. **Who**: each attendee with first name, company, role if known. Match against `people.md`; for unknown attendees, note "new to you" and what their email domain suggests. Mark VIPs.
3. **Recent context**: the last three email threads involving these attendees, one line each, newest first, with dates. Note anything they asked for that is unanswered, or anything the person promised.
4. **Open items**: tasks in `tasks.md` that mention the attendees, company or topic; relevant `notes/` entries.
5. **Agenda**: from the invite description if there is one; otherwise infer from the title and recent threads, and say you inferred it.
6. **Talking points**: two or three, specific to this meeting. Include one question worth asking.
7. **Prep needed**: anything to read, bring or decide before the meeting, in one line, or "nothing".

## Output

Order meetings by start time. One page total in unattended mode: trim talking points before trimming context. Use the person's `language` and `tone`.

Unattended: if no meetings in scope, do nothing and send nothing. Otherwise one email to `delivery_email`, subject `Prep for <Weekday D Month>`. Interactive: in chat, then offer to draft any follow-up or capture any task mentioned.
