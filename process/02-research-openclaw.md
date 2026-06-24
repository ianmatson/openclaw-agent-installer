# Phase 2 — Verify How OpenClaw Works *Right Now*

**Goal:** OpenClaw changes often (calendar versioning, weekly drift). Before you
design or build, learn how the platform actually works *today* — its schema, the
commands you'll run in Phase 5, and the specific integrations this user needs — so
everything you generate and every action you later take matches reality, not stale
assumptions baked into this repo.

**You produce:** `studio/.onboarding/openclaw-current.md` — a pinned snapshot
you'll rely on through Phases 3–6.

**Mindset:** treat every OpenClaw specific written in this repo (commands, config
shapes, examples) as *illustrative and possibly stale.* Confirm the current form
yourself: the live docs (**https://docs.openclaw.ai/**), `openclaw --help` on the
relevant subcommands, and `openclaw config schema`.

---

## 1. Read the docs & pin the version

Read the official documentation. Cover at least: agents & workspaces, the agent
config (`agents.list[]`), the **secrets manager**, **plugins**, the **Discord
channel**, threads & mentions, multi-agent routing, **model providers & auth**, and
**running the gateway as a service**. Record the **current OpenClaw version** you're
designing against — everything you generate and run targets this version.

## 2. Capture what you'll *generate* (Phase 4 needs)

- **Agent config schema** — the real fields for an `agents.list[]` entry today
  (id, model, workspace, identity, bindings…).
- **Required top-level config** — anything an `openclaw.json` must contain to start.
  Confirm whether a `gateway.mode` (or equivalent) is required: *a missing required
  field is a classic silent first-launch failure.*
- **Workspace file conventions** — which markdown files an agent uses and what each
  is for (`AGENTS.md`, `SOUL.md`, `USER.md`, `IDENTITY.md`, `MEMORY.md`).
- **Current model identifiers** — copy the actual current strings. Never rely on a
  model name written elsewhere in this repo.
- **Injection budget** — the per-file and total limits for context loaded at
  session start, so memory files stay within budget.

## 3. Capture what you'll *do* (Phase 5 needs) — the activation surface

This is essential: Phase 5 brings the studio live, so confirm the real commands now.

- **Plugins** — how to list/install/enable a plugin, and specifically the **Discord
  channel plugin** (it is *not* guaranteed present on a fresh install). Record the
  install command and how to confirm it's active (e.g. a channels/status check). A
  missing Discord plugin means bots that never come online.
- **Secrets manager** — the real shape of a secret *reference* in `openclaw.json`
  (source / provider / id, including the file-provider id form) and the commands to
  **store** and **audit** secrets. You will store model keys and bot tokens this
  way — never plaintext.
- **Config validation** — the command(s) to validate a config and diagnose
  problems (validate / doctor). These are your checkpoints in Phases 4–5.
- **Model auth** — *both* flows: logging into an existing **subscription** (the
  user's likely default) and using an **API key**. Record the exact commands and
  what each requires (e.g. whether the subscription login needs a browser).
- **Gateway as a service** — how to install/run the gateway so it **starts on boot**
  and stays up, per OS, and how to check its status. Note the foreground fallback
  for environments without a service manager.
- **Discord channel/binding schema** — how an agent binds to a guild/channel (IDs,
  `requireMention`, threads, DM policy) so Phase 4's bindings are correct.

## 4. Confirm the integrations *this user* needs

From the Phase 1 value blueprint, for **each tool the user chose to integrate**,
confirm against live OpenClaw:

- Is there a current plugin or MCP integration for it (Gmail, Google Calendar, a
  document source, …)? Its name/spec?
- What auth does it need, and does setup require a browser or extra credentials?
- What can it actually do today, and what are its limits?

Record a short per-integration note. **If something the user wanted isn't
available, say so plainly here** so Phase 3 can adjust the design (substitute a
lighter approach, or move it to the roadmap). Far better to learn it now than to
promise it and fail in Phase 5.

## 5. Confirm the under-documented collaboration items

These were flagged during this product's design as inconsistent or
under-documented. Check them and **record what you find** — they shape how agents
collaborate:

- Does a **cross-agent `@mention` actually trigger** the other agent, or does that
  require a gated setting (e.g. `tools.agentToAgent`)? If gated or unavailable, the
  model falls back to "mention the human (or the lead) in public" — never an
  agent-to-agent DM. Note which applies.
- The exact **thread-binding** syntax and how **`requireMention`** behaves when
  multiple agents share a channel.

If something you need isn't documented, say so in the snapshot and choose the most
conservative option that still respects `principles/guardrails.md`.

---

## Gate

No user sign-off needed, but tell the user in one friendly line that you've checked
the latest OpenClaw guidance — and, where relevant, the specific integrations they
asked about — and you're ready to design their team. **Reminder for later:**
re-verify any command or schema in this snapshot *at the moment you use it* in
Phase 5 — the platform moves quickly. Then proceed to `process/03-design-roster.md`.
