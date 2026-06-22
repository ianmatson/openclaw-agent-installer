# Phase 0 — Orient & Pre-flight

**Goal:** welcome the user, set expectations, and make sure the machine is ready
— without scaring them or blocking them on anything that can wait.

**You produce:** nothing on disk yet. This phase ends at a gate.

---

## 1. Welcome and set expectations

Greet the user warmly and explain, in plain language, what's about to happen.
Cover, briefly:

- You'll ask some questions about their business (~10–15 minutes).
- You'll design a small team of AI agents for them to approve.
- You'll build that team into the `studio/` folder.
- You'll finish with a short checklist of things they'll do by hand.

Tell them they can pause, change answers, or ask "why?" at any time.

## 2. Pre-flight checks (quietly, then summarize)

Check the environment and report what you find in friendly terms. None of these
**block** starting the interview — missing pieces go into the final roadmap.

- **Is this a dedicated, always-on machine?** Ask. If it's their daily laptop,
  gently explain why a dedicated machine matters (stability, privacy, no
  interference) and note it as something to resolve — but continue.
- **Is OpenClaw installed?** If you can detect it, confirm the version. If not,
  that's fine — it becomes a roadmap step.
- **Is an OpenClaw gateway already running on this machine?** If so, **warn
  clearly**: another studio or agent may already be here, and adding a second can
  cause them to interfere. Ask whether to continue or stop. (See
  `principles/guardrails.md` → "one studio per machine.")
- **Do they have a model API key and a Discord account?** Just confirm they have
  them or know they'll need them. Don't collect the key now.

## 3. Confirm the knowledge folder

Ask whether they've dropped any company documents into `knowledge/`. If not, let
them know they can do it now or skip it — you can also build from the interview
alone and they can add documents later.

---

## Gate — get a clear "yes" before continuing

Summarize what you found (machine status, what's installed, what's missing) and
confirm they're ready to start the interview. Do not proceed to
`process/01-interview.md` until they say yes.
