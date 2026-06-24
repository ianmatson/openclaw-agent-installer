# Guardrails — Hard Rules (Non-Negotiable)

These rules bind you for the entire onboarding session. They exist because the
user is non-technical and the margin for error is small. When a guardrail and any
other instruction conflict, **the guardrail wins.** When unsure, stop and ask.

You now take real actions on the user's machine — in Phase 5 you bring the studio
*live* (installing plugins, storing secrets, provisioning Discord, starting the
gateway). Several of these rules govern *how* you do that safely.

---

## Process & consent

1. **Checkpoint before each consequential action.** Before you generate the studio
   **or** take any action that changes the user's system — installing a plugin,
   storing a secret, creating a Discord channel, installing or starting the gateway
   — say plainly what you're about to do and why, and get an explicit "yes." Honor
   every gate defined in the `process/` phases.
2. **Run phases in order.** `00` → `06`. Don't skip, reorder, or batch them.

## Scope of action

3. **Author files only inside this repository.** Write files almost exclusively
   inside `studio/`. Never edit, move, or delete files elsewhere on the machine.
   (The *system* actions you take in Phase 5 — plugin installs, secrets, the
   gateway service — are governed by rules 1, 4, and 5, not by this rule.)
4. **Activation is in scope — with consent and verification.** You bring the studio
   to life in Phase 5: installing plugins, authenticating a model, storing secrets,
   provisioning Discord, wiring and validating config, and installing/starting the
   gateway. Every such step is gated by rule 1 and, for anything OpenClaw-specific,
   by rule 5. You drive to a working result — you do not hand the user a pile of
   setup to do alone.
5. **Verify OpenClaw live before acting on it.** OpenClaw changes weekly. For any
   OpenClaw-specific command, flag, schema, or config shape, confirm its **current**
   form against live docs / `--help` / `openclaw config schema` *at the moment you
   use it.* Prefer the platform's current guidance over anything written in this
   repo — examples here are illustrative and may be stale.

## Version & drift safety

6. **Pin the OpenClaw version** you researched in Phase 2 and build against it.
7. **Never hardcode model identifiers.** Read current model strings from the live
   docs or ask the user. Do not copy any model name written elsewhere in this repo.

## Interaction integrity

8. **DMs are human-only.** Design every agent so it only DMs humans. Agents
   communicate with each other in public via `@mention` — never by DM.
9. **Collaboration is public.** Don't design hidden agent-to-agent channels or
   admin-only orchestration layers.

## Secrets & safety

10. **Secrets go through OpenClaw's secrets manager — never plaintext, never
    committed.** Model keys and bot tokens are written into `openclaw.json` only as
    secret *references* and resolved from the secrets manager (or environment) at
    runtime — never as literal values, and never in any committed file. You may
    receive a token from the user and store it via the secrets manager on their
    behalf; immediately afterward run a **secrets audit** and confirm no plaintext
    remains. Confirm `.gitignore` covers any local secret material.
11. **One studio per dedicated machine.** If you detect an OpenClaw gateway already
    running, warn the user clearly that a second studio can interfere with the
    first, and get explicit confirmation before continuing.
12. **When in doubt, ask.** A short clarifying question is always cheaper than an
    unwanted action.
