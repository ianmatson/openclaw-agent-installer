# Your AI Studio

**One command to prepare your computer. One guided conversation to build your AI team.**

Open **Terminal**, paste this command, and press **Enter**:

```bash
curl -fsSL https://raw.githubusercontent.com/ianmatson/openclaw-agent-installer/main/install.sh | bash
```

**macOS · Linux · Windows through WSL2** · Use the **↑ ↓** keys to choose and **Enter** to continue. **Ctrl+C** stops setup.

The installer helps you choose an AI guide, installs missing tools, prepares your
studio folder, and opens your guide with onboarding already started. You do not
need Git, Node.js, OpenClaw, or an AI coding tool installed first.

> **Never opened a terminal?** On a Mac, press **⌘ Space**, type **Terminal**, and
> press **Enter**. On Ubuntu, press **Ctrl+Alt+T**. On Windows, follow the short
> [Windows setup](#windows-setup) below first. Run the command as your normal user,
> without `sudo`.

## What setup feels like

1. **Choose your guide.** Pick Codex or Claude Code based on the account you use.
2. **Choose your studio folder.** The default is `ai-studio` in your home folder.
3. **Review your plan.** See what is already installed and what setup will add.
4. **Let setup work.** Animated progress shows downloads and installation. Existing
   working tools are reused.
5. **Meet your guide.** Sign in, describe your work, and design your team together.

| Guide | Choose it when… | What you need |
|---|---|---|
| **Codex** | You already use ChatGPT or OpenAI. | A ChatGPT account with Codex access, or OpenAI API access. |
| **Claude Code** | You already use Claude or Anthropic. | A Claude account with Claude Code access, or Anthropic API access. |

Both guides follow the same studio setup. **Your guide choice does not lock your
AI team to that provider.** API usage has separate billing. The guide will help
you choose how to power the team and verify current provider support and costs.

## What happens automatically

| Tool or task | Why it is needed |
|---|---|
| Your chosen AI guide | Leads the conversation and builds your studio. |
| Git | Downloads and tracks your studio files. |
| GitHub CLI (`gh`) | Connects to GitHub when you want to save work in your own repository. |
| OpenClaw and its Node.js runtime | Runs your AI team. A missing OpenClaw installation gets its own runtime. |
| Studio download and return command | Prepares the files and gives you one command to continue later. |

The installer uses official tool downloads. New GitHub CLI and OpenClaw installs
stay in your user account. Git may need your computer password. AI guide installers
may add their commands to your shell. The plan appears before these changes.

**A few steps still need you:** signing in, choosing paid services, and creating
Discord bots in your browser. Your guide explains each step when you reach it.
You do not need a GitHub account to download or begin setup. GitHub sign-in can wait
until you want to save to your own **private** repository.

## What you will build

- **1–5 AI teammates** with broad roles shaped around your work: research,
  content, operations, and more.
- **A shared Discord workspace** where you can talk to your team and see agents
  collaborate in public channels.
- **Your own files and configuration**, plus a getting-started guide for using
  the team after it is connected.

Use a **dedicated computer that can stay on** for the live studio. You can explore
on a laptop, but your agents stop responding when their host sleeps or disconnects.
The guide checks for an existing OpenClaw setup before activating a studio.

Have a Discord account ready. You can also place company documents, notes, and
playbooks in `knowledge/` after setup creates the folder.

## Windows setup

This installer runs inside **Ubuntu on WSL2**, a Linux environment on Windows.

1. Open **PowerShell as Administrator** and run `wsl --install -d Ubuntu`.
2. Restart if Windows asks. Open **Ubuntu** and create its username and password.
3. Paste the installer command from the top of this page into **Ubuntu**.

If WSL is already installed, open Ubuntu and use the same installer command.
See [Microsoft's WSL installation guide](https://learn.microsoft.com/windows/wsl/install)
if Windows needs additional setup. For an always-on studio, the Windows computer
must stay awake and the guide must verify service startup inside WSL.

## Pause, return, or recover

Setup prints a return command such as:

```bash
bash ~/ai-studio/.studio-setup/start
```

That command opens your chosen guide in the correct folder, with the tools available.
For a custom folder, use the exact command setup prints.

If installation stops, run the original command again and choose the same folder.
Working tools are reused. Existing studio files are kept, and an existing checkout
is not automatically updated. Errors include a local log path and the next step.
If an existing OpenClaw command is broken, setup stops for repair instead of replacing it.

<details>
<summary>Preview, plain mode, and manual setup</summary>

From a downloaded copy of this repository:

```bash
bash install.sh --preview       # Explore the choices without installing tools
bash install.sh --plain         # Numbered prompts, no color or animation
bash install.sh --no-launch     # Prepare everything, open the guide later
```

Preview may download a temporary, verified UI helper. Use `--preview --plain`
for no downloads or file changes. `NO_COLOR=1` also selects plain mode.

Already have everything? Open Codex or Claude Code in this repository and say
**begin onboarding**. Manual onboarding remains available for other AI coding tools.

The installer supports 64-bit Intel/AMD and ARM macOS and glibc Linux, including
Ubuntu on WSL2. It needs Bash, curl, a terminal, and internet access. Alpine Linux
and native Windows shells are not supported by this installer.

See [installer notes](docs/installer.md) for download sources, local paths, and verification.

</details>

## Inside your studio

| Folder | Purpose |
|---|---|
| `process/` | The steps your guide follows. |
| `principles/` | The rules used to design your team. |
| `reference/` | Examples and integration patterns. |
| `knowledge/` | Your company documents and notes. |
| `studio/` | Your generated AI team and configuration. |

The guide's operating instructions are in [`AGENTS.md`](AGENTS.md).
