---
name: morning-brief
description: A short brief for the day ahead: today's calendar, what is waiting in the inbox, open tasks and three suggested focus items. Use when the person says "morning brief", "what's my day", "what's on today", "brief me", "what do I need to know today", or when a scheduled task names morning-brief.
---

# Morning brief

One screen that lets the person start the day without opening three apps.

## Ground rules

**Mode.** *Unattended* if started from a scheduled task naming this skill: produce the brief and email it to `delivery_email`. *Interactive* otherwise: show it in chat.

**Provider.** Gmail and Google Calendar tools: Google mode. Microsoft 365 tools: Microsoft mode. Neither: stop and name the missing connector.

**Workspace.** `Claude Assistant` folder. Read `profile.md`, `preferences.md` (morning-brief section), `tasks.md`, `people.md`. Honour `length`, `include` and `exclude`. If `profile.md` is missing, point to "set me up" and give a basic brief from calendar and inbox anyway.

**Never** send or move mail, change calendar events, or email anyone except `delivery_email`.

## Gather

1. **Calendar for today** (the person's time zone, from `profile.md`): time, title, attendees (match to `people.md` to use first names), location or link, and whether it is external. Flag anything that needs preparation: first meeting with someone, a meeting with a VIP, back-to-back blocks with no break, travel between locations.
2. **Inbox** since the last brief (or last 24 hours): only mail still in the inbox, which after the organizer means things that matter. Group into **Needs action** (a request, a deadline, a decision), **Needs a reply** (a direct question to the person), **Good to know** (everything else). VIP senders go first within each group. Note threads where the person is the last to be waited on.
3. **Tasks** from `tasks.md`: due today, overdue, and the top open items. Any commitment spotted in the inbox that is not yet in `tasks.md`, note as a suggestion.
4. **Focus**: pick three items that most deserve attention today, from the above, with a short reason each.

## Write

Order: greeting with the person's `address_as` and the date; calendar; inbox; tasks; focus. Length from `preferences.md`:
- *short*: under 150 words, calendar as one line per meeting, inbox as counts plus the two most important items, focus as three lines.
- *standard*: under 300 words.
- *detailed*: under 600 words, with one line of context per inbox item.

Use the person's `language` and `tone`. Plain sentences, no emoji unless their voice uses them, no filler. Times in their local 24h or 12h style, whichever their calendar uses. Mention people by first name once matched.

If a source was unreachable, say so in one line at the top ("I couldn't reach your calendar this morning") and continue with the rest.

## Deliver

Unattended: one email to `delivery_email`, subject `Your brief for <Weekday D Month>`, plain text or simple formatting, nothing attached. Interactive: the same content in chat, then offer: "Want me to prep you for any of these meetings, or draft a reply to anything?"
