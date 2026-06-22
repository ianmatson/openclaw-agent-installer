# Phase 2 — Research the Live OpenClaw Docs

**Goal:** OpenClaw changes often (it uses calendar versioning and ships breaking
changes). Before you generate anything, learn how the platform actually works
*right now*, so the studio you build matches today's schema and best-practice —
not stale assumptions baked into this repo.

**You produce:** `studio/.onboarding/openclaw-current.md` — a pinned snapshot of
what you found.

---

## 1. Read the docs

Fetch and read the official documentation at **https://docs.openclaw.ai/**.
Cover at least: agents & workspaces, the agent config (`agents.list[]`),
the Discord channel integration, threads and mentions, multi-agent routing, and
the current model/provider options.

## 2. Pin the version

Record the **current OpenClaw version** you're designing against. Everything you
generate in Phase 4 targets this version. If the user later upgrades OpenClaw,
this snapshot explains what the studio was built for.

## 3. Capture what Phase 4 needs

Write `studio/.onboarding/openclaw-current.md` with the concrete details you'll
need to generate a valid studio:

- **Agent config schema** — the real fields for an `agents.list[]` entry today
  (id, model, workspace, identity, bindings, etc.).
- **Workspace file conventions** — which markdown files an agent uses and what
  each is for (`AGENTS.md`, `SOUL.md`, `USER.md`, `IDENTITY.md`, `MEMORY.md`).
- **Discord config** — how to bind an agent to a Discord identity/channels,
  `groupPolicy`, DM-isolation settings, mention behavior.
- **Current model identifiers** — copy the actual current strings. Do **not**
  rely on any model name written elsewhere in this repo.
- **Injection budget** — the per-file and total limits for context that gets
  loaded at session start (so memory files stay within budget).

## 4. Confirm the under-documented items

These were flagged during this product's design as inconsistent or
under-documented. Check them against the live docs and **record what you find**,
because they affect how agents collaborate:

- Does a **cross-agent `@mention` actually trigger** the other agent, or does
  that require a gated setting (e.g., `tools.agentToAgent`)? If it's gated or
  unavailable, the interaction model falls back to "mention the human (or the
  lead) in public" — never an agent-to-agent DM. Note which applies.
- The exact **thread-binding** syntax and how **`requireMention`** behaves when
  multiple agents share a channel.

If something you need isn't documented, say so in the snapshot and choose the
most conservative option that still respects `principles/guardrails.md`.

---

## Gate

No user sign-off needed here, but tell the user in one friendly line that you've
checked the latest OpenClaw guidance and are ready to design their team. Then
proceed to `process/03-design-roster.md`.
