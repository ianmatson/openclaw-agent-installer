# Phase 5 — The Non-Technical Roadmap

**Goal:** hand the user a short, friendly checklist of the few things that can't
be automated, written so a non-technical person can complete them confidently.

**You produce:** `studio/NEXT_STEPS.md`.

---

## What to write

Create `studio/NEXT_STEPS.md` as a **numbered, do-this-then-that checklist**.
Plain language, one action per step, with enough detail that the user never has
to guess. Where a step involves a website, name the site and what they'll click.
Where it involves pasting a value, show exactly where it goes.

Cover the manual steps that apply to this user's setup (tailor to what Phase 0
found — skip what's already done):

1. **Install OpenClaw** on the dedicated machine, if not already installed.
2. **Add the AI model key** — where to get it and where to put it (as an
   environment variable, never pasted into a file that gets shared).
3. **Create the Discord server** — the workspace where the studio lives.
4. **Create a Discord application + bot token for each agent** — step through the
   Discord developer portal: new application, enable the needed message
   intents, copy the bot token.
5. **Invite each bot to the server** — build the invite link with the right
   permissions and add it.
6. **Connect the tokens** — where each bot token goes in the configuration.
7. **Approve the pairing** — if OpenClaw uses a pairing code, show how to approve
   it.
8. **Start the studio** — the single command to bring the gateway up, and how to
   tell it's working (say hi to an agent in Discord).

For each step, add a one-line "**why**" so it doesn't feel like blind
button-pushing, and a "**you'll know it worked when…**" cue.

## Grow-it-later section

End with a short, encouraging section on expanding the studio:

- **Add a teammate** — adding an agent is adding a workspace folder and a config
  entry; you (or this setup again) can do it anytime.
- **Reshape an agent** — you can change what an agent does just by talking to it
  in Discord; it updates its own instructions.
- **Bigger steps later** (clearly marked optional/future): connecting SharePoint
  or other document sources, moving to Teams, or a private/local model. Note
  these are roadmap items, not required.

---

## Finish

Tell the user the build is complete: their studio is in `studio/`, and
`studio/NEXT_STEPS.md` is their checklist to bring it to life. Offer to walk
through the first step or two with them. Then **stop** — your job is done.
