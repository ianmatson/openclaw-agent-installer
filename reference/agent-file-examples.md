# Reference — Agent File Examples (good vs. bad)

Use this when generating each agent's workspace in Phase 4. There's one section
per file Phase 4 creates. For each: what the file is for, what to put in, what to
keep out, and a strong example next to a weak counter-example.

**Altitude & length.** OpenClaw injects these files into the agent's context at
the start of every session, with a budget (confirm exact numbers in your Phase 2
snapshot — roughly **~20k characters per file, ~60k total**). Write lean and
high-signal. "Short beats long. Sharp beats vague." Blank files are skipped, and
oversized files get truncated — so don't pad.

---

## `AGENTS.md` — operating instructions

**For:** how the agent works — its operating rules, how it uses memory, and the
interaction primitives. **Keep out:** persona/voice (that's `SOUL.md`) and
secrets.

✅ **Good** — concrete, operational:
```markdown
# Operating Instructions — Research Analyst

- When asked a question, scope it first, then go research before answering.
- Cite sources. Flag confidence. Separate fact from inference.
- Address teammates by @mention in the channel; hand off in the open, never DM.
- Use a thread for any investigation that runs more than a few messages.
- Save durable findings to MEMORY.md; check it before re-researching.
```

❌ **Bad** — vague boilerplate:
```markdown
# Instructions
Be helpful and professional. Do your best to assist the user with their
requests in a thoughtful and comprehensive manner at all times.
```

---

## `SOUL.md` — persona, voice, boundaries

**For:** who the agent *is* — tone, stance, brevity, boundaries. **Keep out:**
operating procedure, backstory filler, security policy.

✅ **Good** — has a take, sharp:
```markdown
# Soul
You are a sharp research analyst. Have an opinion; don't hedge everything.
Lead with the answer, then the why. Call out a weak thesis early.
Short beats long. No filler, no "as an AI."
```

❌ **Bad** — mush that produces a beige agent:
```markdown
# Soul
Maintain professionalism at all times. Provide comprehensive and thoughtful
assistance. Always be polite, helpful, and considerate in every interaction.
```

---

## `USER.md` — who the user/team is

**For:** who the agent serves and how to address them — names/roles,
preferences, context that personalizes every session. **Keep out:** generic
filler; anything sensitive.

✅ **Good** — specific:
```markdown
# The Team
You work with a 4-person venture studio. Primary contacts:
- Nicole (Managing Partner) — wants the bottom line first, detail on request.
- Braden (Analyst) — hands you deep-dive requests; likes sourced tables.
Default to concise written summaries in-channel; expand in a thread if asked.
```

❌ **Bad** — empty/generic:
```markdown
# User
The user is a person who will ask you questions. Help them.
```

---

## `IDENTITY.md` — name, vibe, emoji

**For:** the agent's outward identity — name, one-line vibe, emoji/avatar — so it
reads as a distinct teammate. **Keep out:** long bios.

✅ **Good** — distinct and on-brand:
```markdown
# Identity
name: Atlas
vibe: calm, rigorous research analyst who gets to the point
emoji: 🧭
```

❌ **Bad** — generic, indistinguishable:
```markdown
# Identity
name: Assistant
vibe: helpful AI assistant
emoji: 🤖
```

---

## `MEMORY.md` — seeded company context

**For:** the high-signal company facts this agent needs, distilled from the
interview and the documents in `knowledge/`. **Keep out:** raw document dumps,
duplication of other agents' context, anything that blows the budget.

✅ **Good** — distilled, role-relevant:
```markdown
# What I know
- The firm invests in early-stage wealth-tech and fintech; thesis favors
  compliance-friendly tools for RIAs.
- Decisions run through an investment committee; memos need a clear
  recommendation up top.
- Key playbook: "Diligence Checklist v3" (in knowledge/) — apply it to screens.
```

❌ **Bad** — raw dump, no distillation:
```markdown
# Memory
[pasted the entire 40-page fund deck and three PDFs verbatim]
```
