# Principles — How to Design Good Agents

These are the design rules for the studio you build in Phase 4. They encode what
makes an agent studio genuinely useful rather than a pile of brittle bots.

---

## 1. Employees, not workflows

Design **broad roles**, not narrow tasks. An agent should be something you could
describe as a job — "our research analyst," "our content lead" — not "the thing
that summarizes one PDF." Broad agents stay useful as needs change; narrow ones
rot the moment the task does.

- Good: *Research Analyst* — investigates markets, companies, and theses; you
  bring it a question, it goes and works.
- Bad: *PDF Summarizer Bot* — a single function pretending to be a teammate.

If a proposed agent can be fully described by one verb, it's probably a feature
of a broader agent, not its own seat.

## 2. Keep the roster small and the roles distinct

Cap at **1–5 agents**. Fewer, broader teammates beat many overlapping ones. Each
agent should own a clearly distinct domain — if two agents would constantly
overlap, merge them. Every agent must trace back to a real problem or seat from
the Company Profile; if it doesn't, cut it.

## 3. Default to a library; add structure only when earned

Most clients want a **library of independent specialists** — agents that don't
depend on each other, each reachable in its own channel. Start there.

Introduce more structure **only when the interview surfaces a real need**:

- A **pod** when a few agents genuinely collaborate on shared artifacts.
- An **org / chain of responsibility** (a lead that delegates and aggregates)
  only when there's an actual pipeline or hierarchy in how the work flows.

Never impose a hierarchy by default — it adds coordination cost the client
didn't ask for. Topologies compose: a library can contain one small pod.

## 4. Orchestration happens in public

When agents collaborate, it happens **in shared Discord channels everyone can
see** — handoffs, delegation, reasoning. This is a trust and transparency
feature: it's the client's studio visibly working in the open. Never route
collaboration through a hidden back-channel or an admin-only layer.

## 5. DMs are human-only

An agent **never** DMs another agent. Agent-to-agent communication is always a
public `@mention` in a channel or thread. DMs exist only for a human to talk
privately with an agent. A back-channel between agents erodes the public ethos —
don't build one. (Full interaction rules: `reference/interaction-primitives.md`.)

## 6. Give each agent a real personality, scoped tightly

Each agent gets a distinct voice and identity (`SOUL.md`, `IDENTITY.md`) — sharp,
opinionated, brief. But personality is not permission to be sloppy: operating
rules and boundaries live in `AGENTS.md`. See `reference/agent-file-examples.md`
for the altitude to aim for.

## 7. Seed context, don't hoard it

Give each agent the company context it needs in `MEMORY.md` — distilled, high
signal, within the injection budget. Don't dump raw documents; summarize what
matters for that agent's role.

## 8. Meet the work where it lives

An agent is only as useful as its reach into the user's real tools. Design each
agent around the systems the work actually flows through, at the **integration
depth the user chose** — light (drafts in chat the user acts on) or deep (connected
to the tool, acting directly). Prefer the lightest depth that delivers the value;
deeper access means more leverage but more setup and permission. Only design in
integrations Phase 2 confirmed are real and available today — never promise a
connection the platform can't deliver.
