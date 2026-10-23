# Beyond Personal Assistant

A personal assistant for your Claude account. It learns how your inbox works and agrees a filing plan with you, then keeps the inbox tidy so only what matters stays in front of you. It can send you a morning brief, prepare you for tomorrow's meetings, draft replies in your own voice, and capture tasks, notes and people as you mention them.

**Works with** Gmail, Google Calendar and Google Drive, or Microsoft 365 (work or school accounts).

**To start**, connect your email, calendar and files under Customize → Connectors, then open a normal chat (not the Code tab), use the plus button → Plugins to switch Beyond Personal Assistant on, then type a forward slash and pick setup. Setup takes about half an hour and nothing is moved or sent without your approval.

**Skills**: setup, inbox-organizer, inbox-digest, morning-brief, inbox-triage, meeting-prep, draft-reply, capture, support, request.

**Your data** stays in a folder called Claude Assistant in your own Drive or OneDrive. The assistant never deletes mail, never marks spam, and never sends email to anyone but you unless you confirm it in the conversation.

**For maintainers:** the shared rules every skill follows live in `core/CORE.md` and are injected into each skill by `scripts/sync-core.sh`; `scripts/check-skills.sh` is the gate. Edit the rules there, never inside a skill's generated block.
