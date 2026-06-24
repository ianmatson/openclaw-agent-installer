# Phase 5 — Activate the Studio (bring it to life)

**Goal:** take the generated studio from "valid config" to **working** — agents
online in Discord, responding. You now act as an **operator** on the machine, not
just an author: you install plugins, authenticate a model, provision Discord, store
secrets, start the gateway as a service, and verify a real message round-trip.

**You produce:** a live studio. (Phase 6 writes the getting-started guide.)

---

## How you operate here — read before acting

- **Checkpoint before each consequential action.** Before each system-changing step
  (installing a plugin, logging into a model, storing a secret, creating channels,
  installing/starting the gateway), say plainly what you're about to do and why, and
  get a quick "ok."
- **Verify OpenClaw live, every time.** Re-confirm each command/flag/schema against
  live docs / `--help` / `config schema` *at the moment you use it* — your Phase 2
  snapshot is a guide, not gospel. (guardrails 1, 5.)
- **Secrets through the manager.** Tokens and keys go into OpenClaw's secrets
  manager as references — never plaintext, never committed. After storing any
  secret, run a **secrets audit** and confirm no plaintext remains. (guardrail 10.)
- **One step at a time.** Verify each step before the next. If something fails,
  diagnose (validate / doctor / status) and fix before moving on.

Run these in order.

## 1. Install OpenClaw (if needed) & confirm the command works

If Phase 0 found OpenClaw missing, install it now and confirm `openclaw` runs as a
first-class command on this machine. Confirm the version matches your Phase 2
snapshot; if it drifted, re-check anything you're unsure about.

## 2. Authenticate the model

Use the choice from Phase 1 (subscription vs API key):

- **Subscription:** run the current login flow. If it needs a browser this machine
  doesn't have, guide the user to complete the login on a device that can, and/or
  paste a token — don't get stuck.
- **API key:** store the key in the secrets manager under the reference name the
  config expects.

Verify the model resolves before continuing.

## 3. Install & enable the plugins

Install the **Discord channel plugin**, and any **integration plugins** the design
calls for (Gmail, calendar, …). Confirm each is active (plugins list / channels
status). *This is the step whose omission silently leaves every bot offline — don't
skip the confirmation.*

## 4. Provision Discord (guide the user's browser steps)

Follow **`reference/discord-setup.md`** precisely. This is the one genuinely manual
part, and you walk the user through it conversationally, **one bot at a time.** In
short:

1. **Server & IDs:** the user creates (or picks) the Discord server, enables
   Developer Mode, and copies the **server (guild) ID** and their own **user ID**.
2. **Per bot — create *and* invite together:** for each agent, the user creates the
   application + bot, **enables all three privileged intents** (Message Content,
   Server Members, Presence), generates the OAuth2 invite URL with **Administrator**
   permission (scopes `bot` + `applications.commands`), opens it, and adds the bot
   to the server. Then copies that bot's **token**.
3. Have them hand you each **bot token** and the **IDs** as they go. One bot at a
   time, so nobody gets lost.

Explain *why* each setting matters in a few words ("Message Content intent lets your
bot read messages"), and that Administrator keeps setup simple — they can tighten it
later.

## 5. Store the secrets & wire the IDs

As tokens/IDs arrive:

- Store each **bot token** and the **model key** (if not already) in the secrets
  manager, under the reference names the config expects.
- Fill the **server/user/channel IDs** into the bindings in `openclaw.json` (these
  aren't secrets).
- Run a **secrets audit**; confirm everything resolves and **no plaintext** remains
  anywhere.

Commit the studio (config with IDs + references only — never values).

## 6. Bot-automate the rest of Discord

With a bot in the server holding Administrator, do everything the Discord API
permits so the user doesn't have to click through it — chiefly **create the channel
structure** from Phase 3 (each agent's office + any shared channel), plus any
role/topic setup that helps. Capture the resulting **channel IDs** into the
bindings. Checkpoint before creating things; stick to the agreed structure.

## 7. Start the gateway as a service

Install/run the gateway so it **starts on boot** and stays up — the studio is meant
to be always-on. Use the service-install path Phase 2 identified; verify status
shows running. (If this machine has no service manager — e.g. a bare container —
fall back to running the gateway in the foreground, and tell the user plainly that
on their real always-on machine it should be installed as a service.)

## 8. Verify a real round-trip

The finish line is not "gateway started" — it's "an agent answered." Validate end
to end:

- **config validate** → clean (aside from anything intentionally deferred).
- **channels status / plugins list** → Discord active, bots connected.
- **secrets audit** → all resolved, no plaintext.
- **gateway status** → running.
- **Live test:** have the user say hello to an agent in its channel (and `@mention`
  one to confirm a teammate responds, if it's a pod). Confirm a real reply comes
  back.

If a bot is offline, work the debug list in `reference/discord-setup.md` (intent not
enabled, wrong/again-reset token, plugin not active, binding ID wrong) and fix.

---

## Gate — don't hand off until it works

**Do not proceed to Phase 6 until an agent has actually responded in Discord.** That
live reply is the gate. If the user chooses to defer Discord (e.g. no time today),
note exactly what remains and carry it into the handoff as the one open item — but
the default and goal is to finish here, live.
