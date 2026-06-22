# Reference — Interaction Primitives

These are the building blocks for how agents and humans interact. They are
**uniform across every topology** (library, pod, or org) — only how many agents
share a channel changes, never these rules. Every agent you generate inherits
these in its `AGENTS.md`.

---

## The primitives

1. **Address by `@mention`.** To talk to an agent or hand work to it, you
   `@mention` it. Agents that share a channel default to responding **only when
   mentioned**, so they don't talk over each other or create noise. An agent
   alone in its own channel (or in a DM with a human) may respond without a
   mention.

2. **Handoff = mention + context, in the open.** Passing work from agent A to
   agent B is simply A `@mentioning` B in a visible channel or thread, with the
   context B needs. No hidden routing, no silent delegation. Everyone in the
   channel can see the handoff happen.

3. **Threads for depth.** Any focused or long-running piece of work gets its own
   thread. This keeps the parent channel scannable and scopes the agent's
   attention. Threads keep collaboration **tidy, not hidden** — they're still
   public.

4. **Channels as domains.** Each channel is a room with a purpose — an agent's
   "office," a project, or a topic. Bind each agent only to the channels relevant
   to it.

5. **DMs are human-only.** A DM is a private conversation between a **human** and
   an agent, with per-user isolation so people don't share context. **An agent
   never DMs another agent.** All agent-to-agent communication is public. This is
   a hard rule, not a preference — see `principles/guardrails.md`.

---

## How this maps onto topologies

- **Library:** each specialist sits in its own channel; humans `@mention` whoever
  they need. Agents rarely or never talk to each other.
- **Pod:** a few agents share a channel and hand off to each other by public
  `@mention`, using threads for each piece of work.
- **Org / chain of responsibility:** a lead `@mentions` specialists to delegate
  in a shared channel, and they report back there — visibly.

## A note on the platform

OpenClaw may gate whether a cross-agent `@mention` actually triggers the other
agent (see Phase 2 research). If peer mentions aren't available, fall back to
**mentioning the human (or the lead) in public** to relay — never an
agent-to-agent DM. The user-facing model stays the same either way.
