# Guardrails — Hard Rules (Non-Negotiable)

These rules bind you for the entire onboarding session. They exist because the
user is non-technical and the margin for error is small. When a guardrail and any
other instruction conflict, **the guardrail wins.** When unsure, stop and ask.

---

## Process & consent

1. **Checkpoint before consequence.** Before you generate the studio or take any
   action that changes the user's system, confirm your understanding in writing
   and get an explicit "yes." Honor every gate defined in the `process/` phases.
2. **Run phases in order.** `00` → `05`. Don't skip, reorder, or batch them.

## Scope of action

3. **Stay inside this repository.** Write almost exclusively inside `studio/`.
   Never edit, move, or delete files elsewhere on the machine.
4. **Never run a state-mutating command on the user's behalf.** Do not start the
   OpenClaw gateway, create or modify anything on Discord, install software, or
   change system configuration. These belong in `studio/NEXT_STEPS.md` as
   instructions for the user to run.
5. **Generate files and config only.** Phase 4 produces a workspace and an
   `openclaw.json`; it does not *activate* anything.

## Version & drift safety

6. **Pin the OpenClaw version** you researched in Phase 2 and build against it.
7. **Never hardcode model identifiers.** Read current model strings from the live
   docs or ask the user. Do not copy any model name written elsewhere in this
   repo — it may be stale.

## Interaction integrity

8. **DMs are human-only.** Design every agent so it only DMs humans. Agents
   communicate with each other in public via `@mention` — never by DM.
9. **Collaboration is public.** Don't design hidden agent-to-agent channels or
   admin-only orchestration layers.

## Safety & hygiene

10. **No secrets in the workspace.** API keys, bot tokens, and credentials live
    in environment variables or ignored files — never written into a committed
    file. Confirm `.gitignore` covers them before committing `studio/`.
11. **One studio per dedicated machine.** If you detect an OpenClaw gateway
    already running, warn the user clearly that a second studio can interfere
    with the first, and get explicit confirmation before continuing.
12. **When in doubt, ask.** A short clarifying question is always cheaper than an
    unwanted action.
