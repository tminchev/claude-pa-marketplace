---
name: request
description: Guided intake for asking Beyond Visions for a new feature, a change, or help. Collects the requirements with a short set of questions and emails a complete brief to support. Use when the person says "request", "I'd like to request", "can it also", "I want it to do", "new feature", "can you add", "ask Todor", "request support", "send this to support", or after a support check finds a problem.
---

# Request

plugin_version: 0.1.4

The line above is the version of the assistant that is running right now. Every brief must carry it.

Turn "I wish it could…" into a brief that support can act on first time. Ask one question at a time, accept short answers, and skip anything the person has already told you.

## Ground rules

**Mode.** Interactive only.

**Workspace.** `Claude Assistant` folder. Save the finished brief to `notes/requests/<yyyy-mm-dd>-<short-slug>.md` (create the `requests` folder if needed). If the workspace is not writable, skip saving and say so.

**Support address.** `todor@beyondvisions.ai`. This is the only address this skill ever emails, and only after the person confirms.

## Two kinds of request

- **Problem**: something is not working. Run the `support` skill first if it has not been run in this conversation, then ask only questions 1, 3, 9 and 10 below.
- **Change or new feature**: ask the full set.

## Questions

Ask in this order, one per message. If the person's opening message already answers a question, say what you took from it and move on.

1. **The ask.** "In one sentence, what should your assistant do that it doesn't today?"
2. **Type.** "Is that a change to something it already does, or something new? If existing, which part: inbox organiser, morning brief, meeting prep, triage, replies, capture, or the weekly digest?"
3. **Today and tomorrow.** "Walk me through it. What happens today, step by step, and what should happen instead?"
4. **Frequency.** "How often would you use it, and when? Every day, weekly, when you ask, or when something happens, like an email arriving?"
5. **Systems.** "What information does it need? Your email, calendar, files, or another app, such as invoicing, a CRM, accounting, a booking system? Which one, and do you already have a login?"
6. **People.** "Who else is involved: colleagues, clients, suppliers? Should any of them ever receive something from your assistant automatically?"
7. **Success.** "What does a good result look like? How would you know it worked?"
8. **Limits.** "What must it never do? Anything confidential, anything that always needs your approval, a tone to avoid?"
9. **Priority.** "How important is this, and by when would you like it?" (nice to have / useful / blocking; any date)
10. **Example.** "Can you point me at an example? Forward a sample email to yourself and tell me the subject, or name a file in your Claude Assistant folder."

Stop early if the person says "that's enough" and mark unanswered questions as "not discussed".

## Compile

Write the brief in this structure, in the person's language:

```
Request from <name>, <company> — <date>
Plugin version: <plugin_version from this skill>
Type: <problem | change to <skill> | new feature>
Summary: <one sentence>
Today vs desired: <short paragraph>
Frequency: <answer>
Systems and access: <answer>
People involved / automatic sending: <answer>
Success looks like: <answer>
Must never: <answer>
Priority and date: <answer>
Example: <subject or file name, or none>
Assistant notes: <anything you observed that helps, e.g. which skill is closest, a connector that would be needed>

--- Support report ---
<paste the latest support report if one was produced in this conversation; otherwise "not run">
```

## Send

Show the brief. Ask: "Shall I email this to Beyond Visions support for you, save it, or change something?" On yes: save to `notes/requests/`, then send one email from the person's mailbox to `todor@beyondvisions.ai`, subject `PA request: <summary in under 8 words>`, body = the brief. Confirm in one line with the subject. Never add other recipients.
