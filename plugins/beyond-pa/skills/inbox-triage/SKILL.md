---
name: inbox-triage
description: Works through what is left in the inbox and sorts it into Act, Reply and Read, drafting replies in the person's voice for anything that needs one. Use when the person says "triage my inbox", "what needs a reply", "what needs my attention", "go through my email", "anything urgent", or when a scheduled task names inbox-triage. Drafts only; never sends.
---

# Inbox triage

After the organizer has filed the noise, triage deals with what is left: what needs doing, what needs answering, what can just be read.

## Ground rules

**Mode.** *Unattended* if started from a scheduled task naming this skill. *Interactive* otherwise.

**Provider.** Gmail tools: Google mode. Microsoft 365 tools: Microsoft mode. Neither: stop and name the missing connector.

**Workspace.** `Claude Assistant` folder. Read `profile.md`, `preferences.md`, `voice.md`, `people.md`, `tasks.md`.

**Never** send a reply, forward, move or delete mail. Drafts go into the mail client's Drafts folder and nowhere else. The only email you may send is a summary to `delivery_email` in unattended mode.

## Steps

1. **Scope.** Mail in the inbox since the last triage (or last 24 hours in unattended mode; whatever the person asks in interactive mode). Skip anything already in Review or filed by the organizer.
2. **Classify each thread**:
   - **Act**: asks the person to do something other than reply (approve, pay, sign, attend, decide, send a document) or carries a deadline.
   - **Reply**: a direct question or request addressed to the person that a reply would resolve.
   - **Read**: information only. No reply needed.
   VIPs first in each group. If a thread is both Act and Reply, it is Act and the reply draft mentions the action.
3. **Draft replies** for Reply items, in the person's voice (`voice.md`: greeting, sign-off, formality, sentence length, phrases). Keep each draft short and answer the actual question; where you lack a fact, leave a clearly marked blank like `[date]` rather than inventing it. Save each as a draft reply on the thread. In interactive mode, show each draft and ask "save, change, or skip?" before saving.
4. **Commitments and deadlines.** Anything with a date or a promise the person made or received: offer to add it to `tasks.md` with the due date. In unattended mode, add it to a `## Suggested` section of `tasks.md` rather than to Open.
5. **Summary.** Act items with the one thing needed and any deadline; Reply items with "draft saved" and a four-word gist of the draft; Read items as a count with the two most notable subjects.

## Output

Interactive: the summary in chat, drafts shown one at a time. Unattended: if there is at least one Act or Reply item, one email to `delivery_email` with subject `Inbox: <n> to act on, <m> drafts ready`; if there is nothing in Act or Reply, send nothing. Under 250 words.
