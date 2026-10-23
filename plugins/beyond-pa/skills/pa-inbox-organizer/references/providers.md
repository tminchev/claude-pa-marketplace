# Provider notes for the inbox organizer

Read the section for the mode you are in. Tool names differ between connector versions; look for tools whose names match the operations described and read their descriptions before calling them.

## Google mode (Gmail connector)

- **Categories are labels.** Create one label per category, plus `Review`. If a label already exists with the same name, reuse it. Nested labels (`Assistant/Newsletters`) keep things tidy if the person already has many labels; ask before nesting.
- **Filing** = add the category label, then **archive** (remove the `INBOX` label). The message stays in All Mail and under its label, fully searchable. Nothing is deleted.
- **Suggest mode** = add the label only; do not remove `INBOX`.
- **Undo** = remove the category label and add `INBOX` back.
- **Starred** messages: skip always. **Unread**: filing must not mark as read; use label operations only, never open-and-mark.
- **Finding new mail since last run**: search with `in:inbox after:<unix timestamp or YYYY/MM/DD>`; page through results.
- **Automated mail signals**: sender contains `no-reply`, `noreply`, `notifications`, `newsletter`, `digest`, `mailer`; or the thread's list headers show List-Unsubscribe. Treat `@domain` as the rule key for these.
- **Batch size**: label operations can usually be applied to many messages at once; work in groups of 50 to 100 and report after each batch.

## Microsoft mode (Microsoft 365 connector)

- **Categories are folders.** Create one folder per category under the Inbox, plus `Review`. Reuse existing folders with the same name.
- **Filing** = move the message to the category folder. Nothing is deleted; folders are searchable.
- **Suggest mode**: Outlook has no label-and-leave equivalent that every connector exposes. If the connector offers Outlook *categories* (coloured tags), assign the category tag and leave the message in the Inbox. If it does not, suggest mode becomes **report only**: write what you would have moved to the journal and do not touch the message. Say which of the two you are doing in the first journal entry.
- **Undo** = move the message back to Inbox.
- **Flagged** messages: skip always.
- **Write actions off**: if moving or creating folders fails with a permissions error, the organisation has not enabled write actions for the connector. Stop acting, write a journal entry saying so, and in interactive mode tell the person: "Your Microsoft administrator needs to enable write actions for the Claude Microsoft 365 connector before I can move mail. Until then I can only propose." Do not retry repeatedly.
- **Finding new mail since last run**: search the Inbox folder filtered by received date after the last run; page through results.
- **Shared mailboxes and delegated folders**: leave alone unless the person explicitly includes them.

## Both modes

- Never touch anything that matches a VIP, a never-touch entry, or that is starred/flagged.
- Rules match in this order: never-touch, VIP, exact sender address, `@domain`, `subject contains:`. First match wins.
- A sender that is both a VIP and an automated address (for example a client's ticketing system) is a VIP: ask the person during the audit which they mean.
