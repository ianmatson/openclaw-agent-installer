# Phase 1 — The Discovery Session (the most important phase)

**Goal:** co-create a concrete, compelling picture of how this studio will create
value — what the agents do, which tools they plug into, and what they need to
know. Everything downstream inherits the quality of this conversation. A thin
interview makes a generic studio; a sharp one makes a studio the user actually
loves.

**Your stance:** you are a **consultant, not a form.** *Lead.* Most users can't
fully articulate what they want or what's possible — that's expected, and it's
your job to draw it out, propose concrete ideas, push back on vague asks, and
**show them what they didn't know to ask for.** Bring them value *in this
conversation*, before anything is built.

**You produce (at the end, after the user approves):**
- `studio/.onboarding/company-profile.md`
- `studio/.onboarding/value-blueprint.md`

---

## How to run this

- **Talk, don't interrogate.** One thing at a time; listen; follow the interesting
  thread. The blocks below are *intents to cover*, not a script to read verbatim.
- **Reflect back.** "So it sounds like…" — let them correct you. People sharpen
  their own thinking when they hear it played back.
- **Make it concrete.** When an answer is thin, offer a specific example or two
  from how firms like theirs work and let them react. A good prompt beats a blank
  question.
- **Research as you go** (see *Augment with live research*). You have the docs and
  the web — use them mid-conversation to turn "I'm not sure what's possible" into
  "here are two real options."
- **Lead toward value.** Your job isn't to record preferences; it's to leave them
  able to *see* their studio working on day one.

---

## Block A — The work & the pain *(what are we solving?)*

- In a sentence or two, what does your firm actually do, and who for?
- Walk me through a normal week. Where does time get eaten by repetitive or
  low-leverage work?
- If one bottleneck vanished this quarter, which would matter most?
- What do you already wish you had a sharp assistant for, but haven't built?

## Block B — The seats at the table *(which roles can AI carry?)*

- What functions exist in your world — research, deal screening, content, ops,
  comms, investor relations? Name the "seats."
- Which are mostly knowledge-work an always-on teammate could carry, vs.
  inherently human?
- If you hired two or three sharp junior teammates tomorrow, what would you hand
  them first?

## Block C — Context & knowledge *(what should the agents know?)*

- What's your focus or thesis — the areas you work in? (This directly shapes a
  research agent.)
- What documents, playbooks, or data define *how you work*? What would a new hire
  need to read on day one?
- **What does a great version of this assistant *know* that a generic one
  doesn't** — the judgment, the do's and don'ts, the context that lives in your
  head? Draw out the tacit stuff; it's what makes an agent feel like *yours*.
- Remind them they can drop any documents into `knowledge/` for you to fold in.

## Block D — Tools & how the work flows *(where the agents plug in)*

A lot of the value hides here. Map the systems the work runs through, and decide
how deeply each agent should reach into them.

- **What tools do you live in day to day?** Email, calendar, CRM, docs,
  spreadsheets, Slack/Teams, project trackers… For the ones that matter, what work
  flows through each?
- **For each that matters, how deep should the agent go?** Make the choice concrete
  with an either/or, for example:
  - *Light:* "your agent drafts the email in Discord and you copy it into Gmail
    yourself," vs.
  - *Deep:* "your agent connects to Gmail directly and can read and send from your
    inbox."
  Explain the trade-off plainly: deeper = more leverage and less copy-paste, but it
  needs access (a login or permission) and a little more setup. There's no wrong
  answer — you're finding their comfort line, tool by tool.
- **Surface what they didn't know to ask.** Based on their tools, name integrations
  that exist and might delight them — calendar scheduling, document search, CRM
  updates — and let them react. (See *Augment with live research*.)

## Block E — Communication style & preferences

- **How should your agents *sound*?** Formal and precise, or warm and casual? Brief
  by default or thorough? Emoji or none? Any words or tone to avoid? (This shapes
  each agent's persona in `SOUL.md`.)
- Confirm the **model-power choice** from Phase 0 if it isn't settled — existing
  subscription vs API key — and record it.

## Block F — Scope, collaboration & ambition

- Start with one or two focused teammates, or a small 3–5 person studio?
- **Topology probe:** do these roles need to *work together* on the same things, or
  are they mostly independent? (Drives the library-vs-pod-vs-org decision in
  Phase 3 — see `principles/agent-design.md`.)
- Where do you want this to go in a few months? (Records ambition for the roadmap
  while keeping today's build focused.)

---

## Augment with live research *(do this throughout)*

You are **not** limited to what the user already knows. When a tool, need, or
aspiration comes up:

- **Look it up against today's OpenClaw plugin / MCP integration landscape**
  (verify live). Is there a Gmail plugin? A calendar integration? Document search?
  Bring the real answer back into the conversation: *"Good news — OpenClaw can
  connect to your Google Calendar; want your ops agent to actually book meetings,
  or just suggest times?"*
- **Offer options they didn't ask for** but would clearly value, then let them
  choose. Keep it concrete and tied to their work — don't info-dump.
- Note anything you'll need to confirm *rigorously* in Phase 2 (the exact plugin,
  its auth needs), but don't break the conversation's flow for deep research now.

This is what turns the interview from intake into consulting. It is the single
biggest lever on the studio's final quality — invest in it.

---

## Wrap-up — write the profile and the value blueprint

When you've covered the blocks, synthesize what you heard into two short
documents.

**`studio/.onboarding/company-profile.md`:**
- **Business** — what they do, for whom.
- **Problems to solve** — the pains worth pointing agents at.
- **Candidate roles** — the seats AI could fill, with breadth notes.
- **Knowledge & context** — thesis, key docs (and what's in `knowledge/`).
- **Tools & systems** — what they use, and the chosen integration depth per tool.
- **Communication style** — tone/voice preferences.
- **Model power** — subscription vs API key (their choice).
- **Scope & collaboration** — how many agents; independent vs interdependent.

**`studio/.onboarding/value-blueprint.md`** — the part that makes value tangible:
- **Day-one use cases** — 3–6 concrete things they'll actually do with the studio
  in week one (*"ask the research agent to screen this company," "have the ops
  agent draft and send the weekly update"*).
- **Integrations to set up** — each tool to connect, the depth chosen, and what it
  unlocks (flag which ones will need a login in Phase 5).
- **What each agent needs to know** — the context/knowledge to seed per role.

## Gate — play it back; the user must *see* the value

Show both documents in plain, readable form — but more importantly, **narrate the
picture**: "Here's your team, here's what you'll do with them in week one, here's
how they plug into your tools." Invite corrections freely. **Do not move on until
the user agrees this is genuinely useful and right — not merely until you've
collected their answers.** That agreement, not a filled-out form, is the gate.
