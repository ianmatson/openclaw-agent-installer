# Reference — Discord Setup Runbook

The one genuinely manual part of activation. Discord's own portal can't be
automated (it needs the user's logged-in browser), so the seed agent **guides the
user through these exact steps in Phase 5**, conversationally, **one bot at a
time.** Everything *after* a bot is in the server (creating channels, wiring config)
the agent does itself.

Unlike OpenClaw specifics, this Discord flow is stable — but if a label has moved,
trust what's on the user's screen and adapt.

---

## Before you start: turn on Developer Mode (to copy IDs)

Discord → **User Settings** (gear) → **Advanced** → enable **Developer Mode.** Now
the user can right-click any server, channel, or person and **Copy ID.**

## Step 1 — The server and its IDs

1. Create a new server (the **"+"** in the left server rail → *Create My Own*), or
   choose an existing one to host the studio.
2. Right-click the **server icon** → **Copy Server ID** (this is the *guild ID*).
   Hand it to the agent.
3. Right-click **their own name** (in a channel or the member list) → **Copy User
   ID** — this lets the studio recognize them as the human owner. Hand it over.

## Step 2 — Create and invite each bot (one agent at a time)

The studio uses **one bot per agent**, so each appears as a distinct teammate. For
**each** agent, do all of this before moving to the next:

1. Go to **https://discord.com/developers/applications** → **New Application.** Name
   it for the agent (e.g. "Atlas"). Create.
2. Open the **Bot** tab. (If there's an *Add Bot*, confirm it.) Set the bot's
   name/avatar to match the agent if you like.
3. **Enable all three Privileged Gateway Intents** (same Bot tab), then **Save**:
   - **Presence Intent**
   - **Server Members Intent**
   - **Message Content Intent** ← without this the bot can't read messages at all.
4. **Reset/Reveal Token** → copy the **bot token.** Hand it to the agent. (Treat it
   like a password — the agent stores it in the secrets manager, never in a file. If
   you reset it again later, the old one stops working.)
5. **Invite the bot:** open **OAuth2 → URL Generator:**
   - **Scopes:** `bot` and `applications.commands`.
   - **Bot Permissions:** **Administrator** (keeps setup simple; can be tightened
     later).
   - Copy the generated URL at the bottom, open it in the browser, pick the server
     from Step 1, and **Authorize.**
6. The bot now appears in the server — **offline until the gateway runs**, which is
   expected.

Repeat for every agent. Keeping it strictly one-at-a-time prevents mixed-up tokens.

## Step 3 — Hand everything back

The agent needs, **per bot:** the **token.** And **once:** the **server (guild) ID**
and the owner's **user ID.** Channel IDs are *not* needed from the user — the agent
creates the channels itself in Phase 5 and reads their IDs directly.

---

## Debug — a bot won't come online

Work down this list (most common first):

- **Discord plugin not installed/active** in OpenClaw → install it, re-check
  channels status. *(Bots stay offline even with perfect Discord setup if the plugin
  is missing — this was the #1 real-world failure.)*
- **An intent isn't enabled** (especially Message Content) → enable all three, Save,
  restart the gateway.
- **Wrong or stale token** → if the token was reset after copying, copy the current
  one and re-store it.
- **Bot isn't actually in the server** → re-run the OAuth invite URL.
- **A binding points at the wrong ID** → confirm the guild/channel IDs in
  `openclaw.json` match the real server.
- Still stuck → `gateway status` / `doctor` for a concrete error.
