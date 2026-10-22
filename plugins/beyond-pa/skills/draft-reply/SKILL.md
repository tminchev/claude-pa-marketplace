---
name: draft-reply
description: Drafts a reply to a specific email in the person's own voice and saves it to Drafts. Use when the person says "reply to", "draft a response to", "answer this email", "write back to", "respond to the email from", or asks for a reply in a particular tone such as brief, warm or firm. Never sends without explicit confirmation.
---

# Draft reply

Write the reply the person would have written on a good day, and leave the sending to them.

## Ground rules

**Mode.** Interactive only. If started from a scheduled task, stop; `inbox-triage` handles drafting unattended.

**Provider.** Gmail tools: Google mode. Microsoft 365 tools: Microsoft mode. Neither: stop and name the missing connector.

**Workspace.** `Claude Assistant` folder. Read `voice.md` (always), `people.md` (for the recipient), `tasks.md` and `notes/` if the thread touches an open item.

**Never** send unless the person says "send it" or an unmistakable equivalent after seeing the final draft. Default is to save to Drafts. Never add recipients the person did not name.

## Steps

1. **Find the thread.** From the person's description (sender, subject, "the email from Anna about the invoice"). If more than one matches, show the candidates in one line each and ask.
2. **Read the whole thread**, not just the last message. Note every question asked, every request, any deadline, and the register the other person writes in.
3. **Ask only what you must.** If the reply needs a fact you do not have (a date, a yes/no, a price), ask one question, or draft with a marked blank like `[date]` and say so. Do not ask about tone unless the person's request is ambiguous; use `voice.md` and, if given, the requested tone (brief, warm, firm, formal).
4. **Draft** in the person's voice: their greeting style and sign-off from `voice.md`, their sentence length and formality, answering each question in the order it was asked, with any action or deadline stated plainly. Mirror the other person's formality one notch, never below the person's own floor. No filler openings ("I hope this finds you well") unless `voice.md` shows they use them.
5. **Show the draft** and ask: "Save to drafts, change something, or send?" Apply changes as asked. Save as a reply on the thread, keeping the recipients of the original unless told otherwise.
6. If the thread contained a commitment or date, offer to add it to `tasks.md`.

## Output

The draft in a clear block, then the one-line question. After saving: "Saved to your drafts" and nothing else.
