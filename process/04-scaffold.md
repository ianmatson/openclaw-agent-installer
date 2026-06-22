# Phase 4 — Generate the Studio

**Goal:** build the approved roster into a real OpenClaw workspace inside
`studio/`. This is the one phase that writes the studio's substance.

**You produce:** the full `studio/` contents (see the contract at the bottom).

**Reminder:** generate *files and configuration only.* Do **not** start the
gateway, create anything on Discord, or run any command that changes the user's
running system. Those are roadmap steps for Phase 5.

---

## 1. Generate each agent's workspace

For every approved agent, create `studio/agents/<agent-id>/` containing the
workspace files OpenClaw uses (confirm the exact set in
`studio/.onboarding/openclaw-current.md`):

- **`AGENTS.md`** — the agent's operating instructions, including how it uses
  memory and the interaction primitives. **Embed the primitives** from
  `reference/interaction-primitives.md` so the agent behaves consistently:
  address peers by public `@mention`, hand off in the open, use threads for deep
  work, and **never DM another agent**.
- **`SOUL.md`** — persona, voice, boundaries.
- **`USER.md`** — who the team is and how to address them.
- **`IDENTITY.md`** — name, vibe, emoji/avatar.
- **`MEMORY.md`** — seeded company context, distilled from the interview and the
  documents in `knowledge/`. Keep it high-signal and within the injection budget
  from Phase 2 — distill, don't dump raw documents.

**Apply `reference/agent-file-examples.md` to every one of these files** — match
the "good" examples' altitude and length, avoid the "bad" patterns.

## 2. Generate the OpenClaw config

Write a single **`studio/openclaw.json`** (JSON5) using the schema you captured
in Phase 2 — not from memory and not from examples in this repo. It should:

- Define an `agents.list[]` entry per agent, pointing at its workspace.
- Give each agent its **own Discord identity** (one bot per agent) so they appear
  as distinct teammates.
- Define the **public collaboration channels** (each agent's office, plus any
  shared channel a pod needs).
- Enable **per-user DM isolation** so people don't share context.
- Set mention/thread behavior per what you confirmed in Phase 2.

**Model strings:** use the current identifiers from your research, or ask the
user which provider/model they want. Never copy a model name from this repo.

## 3. Leave the manual wiring for the roadmap

`openclaw.json` will reference things that don't exist yet — the Discord server,
bot tokens, the API key. That's expected. You are producing the *configuration*;
the user creates those credentials in Phase 5. Use clear placeholders and note
each one so Phase 5 can turn them into checklist items.

## 4. Make the studio the user's own repo

Initialize `studio/` as its own git repository and make an initial commit, so the
client owns a clean, versioned workspace they can take anywhere. Confirm secrets
are excluded (the API key and bot tokens live in environment variables / ignored
files, never committed).

---

## Gate

Tell the user what you built — the agents, their offices, how they're organized —
and confirm it matches the approved roster before moving on. Then proceed to
`process/05-handoff.md`.

---

## Contract — what `studio/` should contain after this phase

```
studio/
├── .onboarding/
│   ├── company-profile.md       # Phase 1 (approved)
│   ├── openclaw-current.md      # Phase 2 (pinned version + live schema)
│   └── roster-proposal.md       # Phase 3 (approved)
├── agents/
│   └── <agent-id>/  AGENTS.md  SOUL.md  USER.md  IDENTITY.md  MEMORY.md
├── openclaw.json                # JSON5: agents.list[], Discord bindings, DM isolation
└── NEXT_STEPS.md                # written in Phase 5
```
