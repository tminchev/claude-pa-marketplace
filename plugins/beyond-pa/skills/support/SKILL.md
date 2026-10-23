---
name: support
description: Checks that the personal assistant is set up correctly and produces a short report for support. Use when the person says "something's wrong", "it didn't send", "I didn't get my brief", "health check", "is everything working", "support", "I need support", "check my setup", or when another skill cannot find the workspace or a connector.
---

# Support check

plugin_version: 0.1.2

The line above is the version of the assistant that is running right now. Report it exactly; do not guess it from memory.

Find out what is working and what is not, explain it in plain words, and give the person a report they can send to support without any back-and-forth.

## Ground rules

**Mode.** Interactive. Never change anything; this skill only reads and reports.

**Provider.** Determine from available tools: Google mode, Microsoft mode, or none.

## Checks

Run each, note pass or fail and a one-line detail. Do not stop at the first failure.

1. **Connectors**: which of mail, calendar and files tools are present; provider mode. Try one harmless read on each (list recent mail subjects, today's calendar, search the workspace folder) to confirm they respond.
2. **Workspace**: the `Claude Assistant` folder exists; `profile.md`, `preferences.md`, `inbox-rules.md`, `tasks.md`, `people.md` exist; `profile.md` shows `setup_complete`, `plugin_version`, `workspace_writable`. If writable is unknown, attempt to append a single line to `journal/support-check.md` and record whether it worked.
3. **Routines**: from `preferences.md`, which routines are enabled and their schedules. From `journal/`, the most recent `inbox-*.md` date, which tells you when the organizer last ran. If you are in a Claude Code session and `/schedule list` is available, list the scheduled tasks and compare; otherwise tell the person where to look (Claude app → Code → Scheduled, or claude.ai/code/routines) and ask what they see.
4. **Inbox rules**: status approved or draft, rule count, VIP count, suggest mode on or off and its end date.
5. **Plugin**: the `plugin_version` at the top of this skill is the version running now. Compare it with `plugin_version` in `profile.md`, which is the version at setup. If they differ, the assistant has been updated since setup; that is normal, but say so.

## Explain

Translate every failure into one plain sentence and one action the person can take:
- Connector missing or not responding → "Your <service> connection needs reconnecting. Go to Customize → Connectors, find <service>, select Reconnect."
- Workspace missing → "Your settings folder isn't there. Say *set me up* and I'll recreate it."
- Not writable → "I can read your folder but not write to it. If you use Microsoft 365, your administrator needs to enable write actions for the Claude connector."
- Organizer has not run for more than two days while enabled → "Your inbox organiser hasn't run since <date>. Check it is still switched on under Scheduled."
- Rules in draft → "Your filing plan was never approved, so nothing is being filed. Say *organise my inbox* to finish it."

## Report

End with a copy-paste block:

```
Beyond PA support report, <date>
Provider: <google | microsoft | none>
Connectors: mail <ok|missing|error>, calendar <ok|missing|error>, files <ok|missing|error>
Workspace: <ok|missing>, writable <yes|no|unknown>
Plugin version: <plugin_version from this skill>
Setup: <complete <date> | partial | pending>, set up on plugin <version from profile.md>
Routines enabled: <list with schedules>
Organizer last ran: <date or never>
Rules: <approved|draft>, <n> rules, <n> VIPs, suggest mode <on until <date>|off>
Issues: <one line each, or none>
```

Then: "If you'd like me to send this to support, say *request support* and I'll put it in an email for you." That hands over to the `request` skill.
