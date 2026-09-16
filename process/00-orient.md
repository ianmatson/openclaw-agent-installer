# Phase 0 — Orient & Pre-flight

**Goal:** welcome the user, set expectations for a collaborative working session,
and make sure the machine is ready — without scaring them or blocking them on
anything that can wait.

**You produce:** nothing on disk yet. This phase ends at a gate.

---

## 1. Welcome and set expectations

Greet the user warmly and explain, in plain language, what's about to happen:

- We'll have a short **working session** where I ask about your business and
  **help you discover how to get real value** from a small team of AI agents. I'll
  lead — you don't need to arrive with answers. (Usually ~15–25 minutes; we go at
  your pace.)
- Together we'll design that team, and you'll approve it.
- I'll build it into the `studio/` folder **and bring it to life** — including
  connecting it to Discord so you can actually talk to your agents.
- By the end you'll have a **working studio**, not a pile of homework. The only
  parts you do yourself are a few short clicks in your browser (creating your
  Discord bots), and I'll walk you through every one.

Tell them they can pause, change answers, or ask "why?" at any time.

## 2. Pre-flight checks (quietly, then summarize)

If `.studio-setup/context.txt` exists, read it first. The terminal installer has
already prepared the listed tools. Verify that they still run, reuse them, and
avoid asking the user to repeat installation. This file contains no credentials
and does **not** prove that accounts are signed in or that the studio is active.
If `studio/` already contains generated work, ask where the user stopped and
inspect that work before changing it. Resume at the relevant gate.

The installer chooses the **setup guide**, not the studio's model provider.
Explain that distinction only if needed. Do not assume the guide's subscription
automatically covers OpenClaw usage. Verify current provider support and billing
before proposing a subscription or API authentication path.

Check the environment and report what you find in friendly terms. None of these
**block** starting — missing pieces become early steps we handle together.

- **Is this a dedicated, always-on machine?** Ask. If it's their daily laptop,
  gently explain why a dedicated machine matters (stability, privacy, no
  interference) and note it — but continue.
- **Is OpenClaw installed?** If you can detect it, confirm the version. If not,
  that's fine — installing it becomes an early step in Phase 5.
- **Is an OpenClaw gateway already running on this machine?** If so, **warn
  clearly**: another studio or agent may already be here, and adding a second can
  cause them to interfere. Ask whether to continue or stop. (See
  `principles/guardrails.md` → "one studio per machine.")
- **How do they want to power the agents — an existing AI subscription, or an API
  key?** Surface the choice in plain language: you can either log the studio into
  an AI subscription you already pay for (like Claude or ChatGPT), or use an API
  key (a separate billing credential from the provider). Note plainly that a
  **ChatGPT/Claude subscription is not the same as an API key** — they're different
  logins — and that we'll set up whichever you choose together later. Just surface
  the choice now; don't collect anything.
- **Do they have a Discord account?** Confirm they have one (it's free). It's where
  your studio will live, and you'll do a few guided steps there with me.

## 3. Confirm the knowledge folder

Ask whether they've dropped any company documents into `knowledge/` — theses,
playbooks, process notes, anything that captures how they work. The more the
agents can learn, the more useful they'll be. If they haven't, let them know they
can do it now or later; you can also build from the conversation alone.

---

## Gate — get a clear "yes" before continuing

Summarize what you found (machine status, what's installed, what's missing) and
the plan for the session, then confirm they're ready to start. Do not proceed to
`process/01-interview.md` until they say yes.
