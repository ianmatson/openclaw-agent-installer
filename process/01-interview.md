# Phase 1 — The Company Interview

**Goal:** understand the business well enough to design a genuinely useful team
of agents. This is the most important phase — the quality of everything
downstream depends on it.

**You produce:** `studio/.onboarding/company-profile.md` (created at the end,
after the user approves it).

---

## How to run this

**Talk, don't interrogate.** This is a conversation, not a form. Treat the
questions below as *intents to cover*, not a script to read verbatim. Ask one
thing at a time, listen, follow up on what's interesting, and skip what's already
answered. Reflect back what you hear ("So it sounds like…") so the user feels
understood and can correct you.

Keep it plain-language. If they give a thin answer, probe gently with a concrete
example. Aim to cover all four blocks below.

---

## Block A — The work & the pain *(what problems are we solving?)*

- In a sentence or two, what does your firm actually do, and who for?
- Walk me through a normal week. Where does time get eaten by repetitive or
  low-leverage work?
- If one bottleneck vanished this quarter, which would matter most?
- What do you already wish you had a sharp assistant for, but haven't built?

## Block B — The seats at the table *(which roles can AI carry?)*

- What functions exist in your world — research, deal screening, content, ops,
  comms, investor relations? Name the "seats."
- Which of those are mostly knowledge-work an always-on teammate could carry, vs.
  inherently human?
- If you hired two or three sharp junior teammates tomorrow, what would you hand
  them first?

## Block C — Context & knowledge *(what should the agents know?)*

- What's your focus or thesis — the areas you work in? (This directly shapes a
  research agent.)
- What documents, playbooks, or data define *how you work*? What would a new hire
  need to read on day one?
- Where does that live today — local files, SharePoint, Notion, email? *(Note
  this for the roadmap; deep integrations are a later step.)*
- Remind them they can drop any of those into `knowledge/` for you to fold in.

## Block D — Tools, constraints & ambition *(integrations, scope, topology)*

- Where does your team communicate today — Discord, Teams, Slack?
- What systems hold your data, and are there compliance limits on where it can
  live? *(Surfaces the SharePoint/compliance angle for the roadmap.)*
- Is there a dedicated machine for this, or should we flag that?
- Are we starting with one or two focused teammates, or a small 3–5 person studio?
- **Topology probe:** Do these roles need to *work together* on the same things,
  or are they mostly independent? (Drives the library-vs-pod-vs-org decision in
  Phase 3 — see `principles/agent-design.md`.)

---

## Wrap-up — write the Company Profile

When you've covered the blocks, synthesize what you heard into
`studio/.onboarding/company-profile.md`. Structure it clearly:

- **Business** — what they do, for whom.
- **Problems to solve** — the pains worth pointing agents at.
- **Candidate roles** — the seats AI could fill, with notes on breadth.
- **Knowledge & context** — thesis, key docs (and what's in `knowledge/`).
- **Tools & constraints** — comms platform, data systems, compliance, machine.
- **Scope & collaboration** — how many agents, and whether roles are
  independent or interdependent.

## Gate — user signs off on the profile

Show the profile to the user in readable form. Invite corrections. **Do not move
to research/design until they confirm it reflects their business.**
