# Phase 3 — Design the Roster, Topology & Integrations

**Goal:** turn the approved profile + value blueprint into a concrete proposal:
which agents to build, how (or whether) they relate, where they live in Discord,
and which tools each connects to. This is a design step done *with* the user, not
for them.

**You produce:** `studio/.onboarding/roster-proposal.md` (after the user approves
it). Nothing is built yet.

---

## 1. Read your inputs

- `studio/.onboarding/company-profile.md` and `value-blueprint.md` (Phase 1)
- `studio/.onboarding/openclaw-current.md` (Phase 2) — especially the **confirmed
  integration notes**
- `principles/agent-design.md` — the design rules (read this now)
- `reference/roster-archetypes.md` — broad role inspiration

## 2. Propose 1–5 broad agents

Design **employees, not workflows.** Each agent is a broad, capable role that could
own a domain — not a single narrow task. Cap at five; fewer is often better. For
each proposed agent, specify:

- **Name & role** — what they are, in one line a non-technical user gets.
- **Scope/breadth** — what they own and the kinds of things you'd ask them.
- **Office** — the Discord channel(s) they live in.
- **Integrations** — which tools this agent connects to, at the depth chosen in the
  value blueprint. **Only include integrations Phase 2 confirmed are real and
  available today.**
- **Interaction** — which primitives apply (from
  `reference/interaction-primitives.md`).

Map every agent back to a problem or seat from the profile. If you can't, cut it.

## 3. Choose the minimal topology that fits

Pick the **least structure** that serves the surfaced need. Default to the first:

- **Library (default).** Independent specialists, each in its own office, no
  dependencies between them. Most clients land here. Grow it by adding agents.
- **Pod.** A few agents that genuinely collaborate on shared work — they share
  channels/threads and hand off to each other by public `@mention`.
- **Org / chain of responsibility.** A lead that delegates and aggregates — **only**
  when the profile shows a real pipeline or hierarchy. Don't impose it.

Topologies **compose**: a library of mostly-independent agents may contain one
small pod for the one workflow that needs it. Use the Block F "do these roles work
together?" answer to decide. **Briefly justify your choice** from the interview.

## 4. Design the channel structure

Lay out the Discord channels the studio will use, so Phase 5 can create them:

- An **office per agent** (where the user talks to it), named plainly.
- A **shared channel** only where a pod genuinely collaborates.
- Note where cross-agent handoffs will happen — always **in public**.

Keep it minimal: channels are cheap to add later, clutter is costly now.

## 5. Respect the interaction rules in the design

- Collaboration happens **in public** Discord channels/threads.
- Agents address and hand off to each other by `@mention`, never by DM.
- DMs are reserved for humans talking privately to an agent.

## 6. Ground every choice

Each agent traces to a problem/seat; each integration was confirmed available in
Phase 2; the topology matches the "work together?" answer. **If an integration the
user wanted isn't available, say so** and offer the lighter alternative or roadmap
it — never silently drop it or over-promise it.

---

## Gate — user approves the roster, topology & integrations

Present the proposal in plain language: here's your team, what each one does, which
tools they connect to, how they're organized, and why. Invite edits — add, remove,
rename, re-scope, change the topology or an integration's depth. **Get an explicit
"yes" before writing the proposal file and moving to Phase 4.** Save the approved
version to `studio/.onboarding/roster-proposal.md`.
