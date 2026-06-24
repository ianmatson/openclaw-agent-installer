# Phase 4 — Generate the Studio

**Goal:** build the approved design into a real, **valid, activation-ready**
OpenClaw workspace inside `studio/`. This phase writes the studio's substance;
Phase 5 brings it to life.

**You produce:** the full `studio/` contents (see the contract at the bottom).

**Note:** you generate files and configuration here, and you **validate** them —
but you don't yet create Discord bots or start the gateway (that's Phase 5, where
the tokens get created). Write the config so Phase 5 can light it up without
rework: real schema, required fields present, secrets *referenced* not embedded.

---

## 1. Generate each agent's workspace

For every approved agent, create `studio/agents/<agent-id>/` containing the
workspace files OpenClaw uses (confirm the exact set in
`studio/.onboarding/openclaw-current.md`):

- **`AGENTS.md`** — the agent's operating instructions, including how it uses memory
  and the interaction primitives. **Embed the primitives** from
  `reference/interaction-primitives.md`: address peers by public `@mention`, hand
  off in the open, use threads for deep work, and **never DM another agent**.
- **`SOUL.md`** — persona, voice, boundaries. **Reflect the communication style the
  user described in Phase 1** (formality, brevity, emoji, tone to avoid) — this is
  where their preference becomes the agent's voice.
- **`USER.md`** — who the team is and how to address them.
- **`IDENTITY.md`** — name, vibe, emoji/avatar.
- **`MEMORY.md`** — seeded company context, distilled from the value blueprint's
  "what each agent needs to know" and the documents in `knowledge/`. High-signal,
  within the injection budget from Phase 2 — distill, don't dump.

**Apply `reference/agent-file-examples.md` to every one of these files** — match the
"good" examples' altitude and length, avoid the "bad" patterns.

## 2. Generate the OpenClaw config (valid + activation-ready)

Write a single **`studio/openclaw.json`** (JSON5) using the schema you captured in
Phase 2 — not from memory, not from this repo's examples. It must:

- Include **every required top-level field** Phase 2 identified (e.g. the gateway
  mode / required keys) so the gateway can actually start. *A config missing a
  required field is the #1 cause of a dead first launch.*
- Define an `agents.list[]` entry per agent, pointing at its workspace.
- **Enable the plugins the design needs** — the Discord channel plugin, plus any
  integration plugins (Gmail, calendar, …) from Phase 3. (You'll install/activate
  them in Phase 5; declare them here so the config is coherent.)
- Give each agent its **own Discord identity** (one bot per agent) so they appear as
  distinct teammates.
- Define the **channels** from Phase 3 (each office + any shared pod channel).
- Enable **per-user DM isolation** so people don't share context.
- Set mention/thread behavior per what you confirmed in Phase 2.
- Wire the **Discord bindings** (guild/channel). Leave the concrete IDs as
  clearly-named placeholders the user will fill from their own server in Phase 5 —
  the server doesn't exist yet.

**Secrets — references, never values.** Model keys and bot tokens are written as
**secret references** in the shape Phase 2 confirmed (e.g. source/provider/id),
pointing at names like one model-key reference and one per bot. The *values* don't
exist yet — Phase 5 creates the bots and stores their tokens in the secrets manager
under these names. **Never write a literal key or token** into `openclaw.json` or
any committed file.

**Model strings:** use the current identifiers from your research, or ask the user
which provider/model they want. Never copy a model name from this repo.

## 3. Validate before you leave the phase

Run the config-validation command Phase 2 identified (verify it live first) against
`studio/openclaw.json` and **fix everything it flags.** Unresolved secret references
— the tokens that don't exist yet — are *expected* at this point; note them.
Everything else should be clean. The studio should be one credential-creation step
away from launch.

## 4. Make the studio the user's own repo

Initialize `studio/` as its own git repository and make an initial commit, so the
client owns a clean, versioned workspace they can take anywhere. Confirm
`.gitignore` excludes secrets and that **no secret values** are present — only
references.

---

## Gate

Tell the user what you built — the agents, their voices, their offices, and the
tools they'll connect to — and confirm it matches the approved design. Then proceed
to `process/05-activate.md` to bring it to life.

---

## Contract — what `studio/` should contain after this phase

```
studio/
├── .onboarding/
│   ├── company-profile.md      # Phase 1 (approved)
│   ├── value-blueprint.md      # Phase 1 (approved)
│   ├── openclaw-current.md     # Phase 2 (pinned version + live schema/commands)
│   └── roster-proposal.md      # Phase 3 (approved)
├── agents/
│   └── <agent-id>/  AGENTS.md  SOUL.md  USER.md  IDENTITY.md  MEMORY.md
└── openclaw.json               # JSON5: agents, plugins, channels, bindings,
                                #        DM isolation, secret *references*
```

*(`GETTING_STARTED.md` is written in Phase 6, once the studio is live.)*
