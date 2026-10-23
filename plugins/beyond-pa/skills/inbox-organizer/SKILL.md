---
name: inbox-organizer
description: Understands a messy inbox, agrees a filing plan with the person, cleans up the backlog, then keeps the inbox tidy on a schedule. Use when the person says "organise my inbox", "clean up my email", "my inbox is a mess", "sort my mail", "file my emails", "set up labels or folders", during setup, or when a scheduled task names inbox-organizer. Never deletes mail or marks spam.
---

# Inbox organizer

The person's inbox is overloaded and they cannot find things. Your job is to leave the inbox holding only what matters and to put everything else somewhere predictable and searchable. You do this in four phases. Phases 1 to 3 run with the person present. Phase 4 runs on a schedule without them.

The guiding rule: **predictable beats clever**. File by *who sent it*, never by guessing what a message is about. If no rule matches, it goes to Review, where the person decides.

## Ground rules

**Mode.** You are in *unattended mode* if this conversation started from a scheduled task prompt naming this skill and nobody is replying; then run phase 4 only. Otherwise you are in *interactive mode* and start at phase 1, or at the phase the person asks for.

**Provider.** Gmail tools mean *Google mode* (labels + archive). Microsoft 365 tools mean *Microsoft mode* (folders + move). See `references/providers.md` for the exact operations and limits. Neither available: stop and name the missing connector.

**Workspace.** `Claude Assistant` folder in Drive or OneDrive. This skill owns `inbox-rules.md` and writes logs to `journal/`. Read `profile.md`, `preferences.md` and `people.md` first. If `profile.md` is missing, send the person to "set me up".

**Never:** delete mail, mark spam, unsubscribe, reply, forward, or send to anyone other than the person's own `delivery_email`. Never touch VIP or never-touch senders. Never file by content guesswork. Everything you do must be reversible with one action, which is why you only ever label and archive, or move to a folder.

## Phase 1: audit (interactive)

Say what you are about to do in two sentences and that nothing will move yet.

1. **Sample, and prove it.** The window is the last **90 days**, never less. Google mode: search `newer_than:90d` (inbox and archived mail, so do not add `in:inbox`), page through results until you have at least **300 messages** or the window is exhausted; aim for up to 1,000. Microsoft mode: search the Inbox and its subfolders for mail received in the last 90 days, paging the same way. Keep a running count. Before you propose anything, state the sample in one line: "I looked at N messages from the last 90 days, from M different senders." If N is under 300 and the window is not exhausted, you have not finished sampling; keep paging. Never infer VIPs or categories from a single day or a single page.

2. **Group by sender and domain.** For each sender, note: count, whether it is automated (no-reply addresses, List-Unsubscribe header, "notification", "newsletter", "digest", "receipt", "invoice", "alert" patterns), whether the person ever replied to it, and whether it appears in their calendar as an attendee or in `people.md`.

3. **Propose categories from what you found.** Do not start from a fixed list. Name the groups the way this person would, for example "Newsletters", "Shop receipts", "Bank and finance", "Project Alpha", "School", "Team", "Clients", "Tools and notifications". Three to eight categories is the usual range. **Review** always exists. Keep names short, Title Case, no slashes.

4. **Present the proposal**, grouped by proposed category, with the top senders and counts in each, and a one-line reason. Mark groups where you are unsure with a question mark. Then ask, one group at a time, starting with the uncertain ones:
   - "Does this group belong together, and is the name right?"
   - For any sender with replies from the person: "This looks like a real conversation. Should it stay in your inbox or be filed?"
   - **VIPs from evidence, not from memory.** List the people the person replied to most and the calendar attendees they meet most, as a numbered list with a one-line reason each ("replied 14 times", "3 meetings this month"). Ask: "Which of these must always reach you? Reply with numbers, and add anyone I missed." Write the confirmed set to `people.md` under VIP, with the others under Regular.
   - "Is there anything I must never touch? For example a folder you manage yourself, or mail from a particular system." Add to never-touch.
   - "Anything that should be filed by subject rather than sender?" Accept only clear patterns such as an invoice number prefix or a project code.

5. **Check the edges.** Ask about: mail older than the sample (file it the same way, or leave it), starred or flagged mail (always left alone), unread mail (filing does not mark it read), shared or delegated mailboxes (left alone).

## Phase 2: rulebook (interactive)

Write `inbox-rules.md` using the structure in the setup templates: categories with one-line definitions, VIPs, never-touch, a rules table of `match → category`, status `draft`. Rules match on exact sender address, on `@domain`, or on an explicit `subject contains:` pattern. Prefer domain rules for automated senders and exact addresses for people.

Show the person the whole rulebook in plain language, not as a table dump: "Everything from these 12 newsletter senders goes to Newsletters. Everything from your bank goes to Bank and finance. Mail from these 9 people always stays in your inbox." Ask: "Shall I go ahead with this?" Only when they say yes, set `status: approved` and `approved_on`. Create the labels or folders now, one per category, plus Review, using the provider notes.

## Phase 3: backlog clean-up (interactive)

Say how much there is and that you will do it in batches. Then, batch by batch (100 to 200 messages):

1. Apply the rules to inbox messages, newest first. Google mode: add the category label and archive. Microsoft mode: move to the category folder.
2. Skip VIPs, never-touch, starred/flagged, and anything matching no rule, which gets the Review label or folder but stays in the inbox.
3. After each batch report counts per category in one line and ask "carry on?" Stop when the inbox holds only VIP mail, real conversations and Review items, or when the person says stop.
4. Write `journal/inbox-<date>.md`: counts per category, number left in Review, batches done, anything odd.

If the person wants a mistake undone: find the message, remove the label and move back to inbox (Google) or move back to Inbox (Microsoft), and offer to turn that into a rule change.

## Phase 4: ongoing (unattended, from a scheduled task)

1. Read `preferences.md` (inbox-organizer section), `inbox-rules.md` (must be `approved`; if not, do nothing and stop), and the newest `journal/inbox-*.md` for the last run time. If there is no journal, use the last 24 hours.
2. Fetch mail that arrived in the inbox since then, up to `max_items_per_run`.
3. For each message: VIP or never-touch, skip. Starred or flagged, skip. Matches a rule: if `suggest_mode: on`, add the category label (Google) or add the category to the subject-independent category marker described in `references/providers.md` (Microsoft) and leave it in the inbox; if `suggest_mode: off`, label and archive (Google) or move (Microsoft). Matches nothing: Review label or folder, stays in the inbox.
4. Write `journal/inbox-<date>.md` with the run time, counts per category, Review count, and the senders that landed in Review, so the digest can ask about them.
5. Send nothing, unless a connector failed or the rulebook could not be read; then one short email to `delivery_email` saying what went wrong.

Later runs the same day append to the same journal file.

## Output style

Interactive: short paragraphs, counts in a compact list, one question at a time. Normal chat has no buttons: when offering options, number them and ask for a number, so the person can answer "2" or "1 and 3". Never show raw message IDs or tool output. Unattended: silent except the journal and the error email.
