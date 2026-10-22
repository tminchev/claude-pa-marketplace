# Workspace file templates

Create each file in the `Claude Assistant` folder. Replace values in angle brackets. Keep the headings exactly as written; other skills look for them.

## profile.md

```
# Profile

name: <first name>
address_as: <how they like to be addressed>
role: <role>
company: <company>
timezone: <IANA zone, e.g. Europe/London>
working_days: <e.g. Mon-Fri>
working_hours: <e.g. 09:00-18:00>
delivery_email: <address briefs are sent to>
language: <e.g. English>
provider: <google | microsoft>
workspace_writable: <yes | no>
inbox_audit: <done | skipped | pending>
setup_complete: <date | partial | pending>
plugin_version: <version>

## Notes
<anything else learned during setup that other skills should know>
```

## preferences.md

```
# Preferences

## inbox-organizer
enabled: <yes | no>
cadence: <e.g. every 2 hours, 07:00-19:00, working days>
cron: <expression>
suggest_mode: <on | off>
suggest_mode_until: <date>
max_items_per_run: 200

## morning-brief
enabled: <yes | no>
time: <HH:MM>
days: <working days | every day>
cron: <expression>
delivery: <email | on request>
length: <short | standard | detailed>
include: <list or none>
exclude: <list or none>

## meeting-prep
enabled: <yes | no>
time: <HH:MM>
cron: <expression>
scope: <all | external only>
delivery: <email | on request>

## inbox-digest
enabled: <yes | no>
day: <weekday>
time: <HH:MM>
cron: <expression>

## inbox-triage
enabled: <yes | no>
times: <e.g. 11:07 and 15:07>
cron: <expression>

## general
tone: <from voice interview, one or two words>
```

## voice.md

```
# Voice

greeting: <e.g. "Hi Anna," >
sign_off: <e.g. "Best, Todor">
formality: <casual | neutral | formal>
sentence_length: <short | medium | long>
tone_words: <two or three words>
phrases_used: <list>
phrases_avoided: <list>
never_write: <list>

## Examples
<two or three short excerpts of their own writing, with permission>
```

## inbox-rules.md

```
# Inbox rules

status: <draft | approved>
approved_on: <date>
last_updated: <date>

## Categories
<one line per category: name — what belongs here. "Review" is always present.>

## VIPs (never filed, always stay in the inbox)
<one per line: name <email>>

## Never touch (leave exactly as they are)
<one per line: sender, domain or subject pattern>

## Rules
| Match | Category |
|---|---|
| <sender email, @domain, or "subject contains: ..."> | <category> |

## Corrections log
<date — what was corrected — rule added or changed>
```

## tasks.md

```
# Tasks

## Open
- [ ] <task> (due: <date or none>) (added: <date>)

## Done
```

## people.md

```
# People

## VIP
- <Name> <email> — <role / relationship> — <notes>

## Regular
- <Name> <email> — <role / relationship> — <notes>
```
