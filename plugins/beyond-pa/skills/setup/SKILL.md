---
name: setup
description: First-time setup and later reconfiguration of the Beyond Personal Assistant (beyond-pa). ALWAYS use this skill, before anything else, when the person says "set up my personal assistant", "set up my assistant", "set me up", "setup", "onboard me", "get started with my assistant", "start onboarding", "change my preferences", "change my routines", "reconfigure my assistant", "set up again", or when another beyond-pa skill finds that the Claude Assistant workspace or profile is missing. This is about the person's email, calendar and files assistant, never about a code repository or development environment.
---

# Setup

You are setting up a personal assistant for one person. Work through the four parts below in order, one question at a time, in a warm and efficient tone. Confirm what you heard before writing anything. The person is usually not technical: explain what you are doing in one short sentence when it helps, and never show raw tool output.

If the person asks only to change preferences or routines, skip to Part C. If they ask to redo the inbox audit, skip to Part B.

## Ground rules

**Mode.** Setup always runs in interactive mode with the person present. If this conversation started from a scheduled task, stop and say setup must be run in a chat.

**Provider.** Look at the tools you have. Gmail, Google Calendar and Google Drive tools mean *Google mode*. Microsoft 365 tools (Outlook mail, calendar, OneDrive) mean *Microsoft mode*. If you have neither, go to Part A step 1 and wait there.

**Workspace.** A folder named `Claude Assistant` in the person's Google Drive or OneDrive. It holds `profile.md`, `preferences.md`, `voice.md`, `inbox-rules.md`, `tasks.md`, `people.md`, and two subfolders `notes` and `journal`. You create it in Part A. Every other skill reads from it.

**Choices.** Normal chat has no buttons. Whenever you offer options, number them and say "reply with a number", so the person can answer 1, 2, or "1 and 3". Keep lists to five or fewer.

**Never** send email, move mail, create events or share files during setup unless the person explicitly says yes to that specific action. Setup never deletes anything.

## Part A: profile and workspace

1. **Connectors.** Check which tools you have. Tell the person what you can see in one line, for example "I can see your Gmail, Google Calendar and Google Drive." If mail, calendar or files are missing, say which one is missing and how to add it: *Customize → Connectors*, find Gmail / Google Calendar / Google Drive, or Microsoft 365, select Connect, sign in. Wait until they say it is done, then check again. Do not continue without at least mail and files. If files are missing in Microsoft mode, say that the Microsoft 365 connector covers OneDrive and ask them to check it is connected.

2. **Who they are.** Ask, one at a time, and accept short answers: first name and how they like to be addressed; role and company (one line); time zone or city; usual working days and hours; the email address briefs should be sent to (default: the connected mailbox); preferred language for briefs.

3. **Create the workspace.** Create the folder `Claude Assistant` in their Drive or OneDrive, with subfolders `notes` and `journal`. Create the files below using the templates in `assets/workspace-templates.md`, filling in what you know. Tell them: "I've created a folder called Claude Assistant in your Drive. That's where I keep your settings and notes. You can open it any time; I never store anything about you anywhere else."

4. **Voice.** Say you will learn how they write so drafts sound like them. Ask them to forward themselves, or point you to, two or three emails they wrote and are happy with; in Google or Microsoft mode you can also search their Sent mail for recent messages longer than four sentences, with their permission. From those, note greeting style, sign-off, sentence length, formality, phrases they use, and anything they avoid. Ask two direct questions: "How do you want to sound in replies, in one or two words?" and "Anything you never want me to write?" Write `voice.md` and read back a three-line summary for approval.

After the voice summary is approved, go straight to Part B. Do not ask about tasks or contacts here; the inbox audit finds the people they deal with and asks about them with evidence.

## Part B: inbox audit

Say: "Now I'll look at your inbox: the last two to three months, who writes to you, what is noise and what is real. I'll show you what I find and we'll agree together what goes where. Nothing moves until you approve the plan." Then start immediately; do not ask any more questions before showing findings. Then follow the `inbox-organizer` skill, phases 1 and 2, exactly. The audit proposes VIPs from the people the person actually replies to and meets; confirm them there and write them to `people.md`. Come back here when `inbox-rules.md` is approved. If the person wants to skip this for now, write `inbox_audit: skipped` in `profile.md` and continue.

## Part C: routines

Explain in two sentences: "I can also do a few things on a schedule, in the cloud, even when your computer is off. Each one arrives as an email from me. Let's go through them; you can say no to any of them."

For each routine below, ask the questions listed, one at a time, and write the answers to `preferences.md`. Offer the default in the question so they can just say "yes".

**Inbox organiser** (keeps the inbox tidy using the approved rulebook)
- Do you want this on? Default yes if the audit was done, otherwise skip.
- How often? Default every two hours during your working day.
- For the first week I'll only label things and leave them in your inbox so you can see what I would have done. After that I move them out. OK? (`suggest_mode: on`, with an end date seven days from today.)

**Morning brief** (today's calendar, what's waiting in your inbox, your open tasks, three suggested focus items)
- Do you want this on? Default yes.
- What time? Default 07:07 on working days.
- Delivered by email, or only when you ask? Default email.
- How long? Short (under 150 words), standard (under 300), detailed.
- Anything to always include or leave out? For example weather, personal calendar, a particular project.

**Meeting prep** (the evening before, a one-page prep for each meeting tomorrow)
- Do you want this on? Default yes if they have more than three meetings a week.
- What time? Default 17:07.
- Only for meetings with people outside the company, or all meetings? Default all.

**Inbox digest** (once a week: what I filed where, anything I was unsure about, and a chance to correct me)
- Do you want this on? Default yes if the inbox organiser is on.
- Which day and time? Default Friday 16:07.

**Inbox triage** (optional: twice a day I draft replies to emails that need one and leave them in your Drafts)
- Do you want this? Default no. Explain it is easy to switch on later.

Write `preferences.md` and read back a short table of what is on, when, and how it arrives.

## Part D: scheduling and persona

1. For every routine switched on, produce a scheduled task definition using the templates in `assets/task-prompts.md`, with every placeholder filled from `profile.md` and `preferences.md`. Present them one at a time, each with a **name**, a **schedule** in plain words, a **cron expression**, and the **prompt** in a code block.

2. Tell the person how they get created, in these words: "These run in the cloud on your Claude account. To create them, open the Claude app, go to the Code tab, choose Scheduled, select New task and Create with Claude, and paste one of these in. If someone is helping you set up today, they can do this with you now." If you are in a Claude Code session where `/schedule` is available, offer to create them yourself, one at a time, confirming each.

3. Produce the **persona text** for *Settings → Profile preferences* using `assets/persona.md`, filled in. Explain: "Paste this into Settings → Profile, under what Claude should know about you. It helps every chat remember how to work with you."

4. Write `setup_complete: <today's date>` and `plugin_version: 0.1.4` to `profile.md`.

5. Run the `morning-brief` skill once, interactively, so they see what it looks like. Then close with four lines: what runs when; that they can keep a task list by saying "add a task" or "remind me" whenever they like (do not ask for tasks now); how to ask for things ("just tell me"); and how to get help ("say *I need support* or *I'd like to request something*").

## If something goes wrong

- A file write fails in Microsoft mode: the person's organisation may not allow Claude to create files. Say so plainly, tell them their administrator can enable write actions for the Microsoft 365 connector, and continue in read-only mode: keep the profile and preferences in this conversation's summary and ask them to paste it into Settings → Profile preferences instead.
- The person wants to stop part way: write what you have, mark `setup_complete: partial` in `profile.md`, and tell them "say *set me up* to continue where we left off".
