# Your AI Studio — Guided Setup

This is a **guided setup that builds your own team of AI agents**. You answer a
few questions about your business in plain language, and an AI assistant designs
and assembles a small studio of agents tailored to how you actually work — then
hands you a short checklist of the last manual steps.

You do **not** need to be technical to run this. The assistant walks you through
everything and never assumes you know the jargon.

---

## What you'll end up with

- **1–5 AI "employees"** — broad, capable agents shaped around your real needs
  (think roles, not robots): a research analyst, a content lead, an operations
  helper, and so on.
- **A shared Discord workspace** where you and your team talk to the agents, and
  where the agents collaborate **in the open** so you can see their work.
- **A clear roadmap** (`NEXT_STEPS.md`) of the few things you'll finish by hand,
  written step by step.

Everything that gets built is **yours** — the files, the configuration, the
knowledge. You own all of it.

---

## Before you start

A few things to have ready. The setup assistant will check for these and help
you if anything is missing — none of them block you from *starting*:

- [ ] **A dedicated, always-on machine.** This studio should live on its own
  computer that can stay running — not your everyday laptop that sleeps and
  closes. (See "Why a dedicated machine" below.)
- [ ] **OpenClaw installed** on that machine. (The roadmap covers this if it's
  not yet installed.)
- [ ] **An AI model key** (e.g., from Anthropic or OpenAI) — this is what powers
  the agents.
- [ ] **A Discord account** — free, and where you'll talk to your studio.

---

## How to run it

1. Make sure this folder is on your dedicated machine.
2. Open your AI coding assistant (Claude Code, Codex, or similar) **in this
   folder**.
3. Say:

   > **begin onboarding**

That's it. The assistant takes over from there: it asks about your business,
proposes a team for you to approve, builds it into the `studio/` folder, and
gives you your `NEXT_STEPS.md` checklist.

If you have company documents, notes, theses, or playbooks you'd like the agents
to know, drop them into the **`knowledge/`** folder first — the assistant will
read and fold them in.

---

## Why a dedicated machine?

OpenClaw is designed to run as one always-on service per machine. Running it
alongside other agent setups on a shared computer can cause them to interfere
with each other. A dedicated, always-on machine keeps your studio stable,
private, and fully under your control. The setup assistant will flag this if it
detects a conflict.

---

## What's in this folder

| Folder | What it's for |
|---|---|
| `process/` | The step-by-step script the assistant follows. You don't edit this. |
| `principles/` | The design rules the assistant builds your agents by. |
| `reference/` | Examples and patterns the assistant uses for quality. |
| `knowledge/` | **You** drop company docs here for the agents to learn from. |
| `studio/` | Empty until setup runs — then it becomes **your** AI studio. |

Curious how it all works under the hood? Start with `AGENTS.md`.
