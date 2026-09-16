# Installer notes

`install.sh` is a standalone Bash 3.2 script. No npm package or build step is
required to start it. The README command also works before Git is installed.

## Flow and terminal behavior

- The final compound command is parsed before stdin is reattached to `/dev/tty`.
  This lets `curl | bash` accept keyboard input and hand the terminal to the guide.
- [Gum](https://github.com/charmbracelet/gum) supplies keyboard selection, styled
  headings, folder input, confirmations, and animated spinners. Its temporary
  binary is checked against the release's SHA-256 manifest before execution.
- If Gum cannot download or run, setup continues with numbered prompts.
  `--plain`, `STUDIO_PLAIN=1`, `NO_COLOR=1`, and `TERM=dumb` select this mode.
- Install approval happens after the plan. Sign-in stays in the vendor CLI and
  is never redirected into an installation log. No permission-bypass flags are used.
- Existing tools must pass `--version` to count as ready. Existing OpenClaw
  installs are never upgraded by this script. Upstream upgrade paths can restart
  services, so a broken existing command stops for repair.
- Existing studio checkouts are identified by origin and required files. Their
  files and branch are preserved. New downloads use a staging directory before rename.

## Sources

| Component | Installation source |
|---|---|
| Gum 2.0.1 | [Official GitHub release](https://github.com/charmbracelet/gum/releases/tag/v2.0.1), with checksum verification. |
| GitHub CLI 2.101.0 | [Official GitHub release](https://github.com/cli/cli/releases/tag/v2.101.0), with checksum verification. |
| Git | Apple command line tools on macOS, or the Linux system package manager. |
| OpenClaw | [Official local-prefix installer](https://docs.openclaw.ai/install/installer), with `--no-onboard`. It manages its private Node runtime. |
| Codex | [Official standalone installer](https://developers.openai.com/codex/cli), with non-interactive installation. |
| Claude Code | [Official native installer](https://code.claude.com/docs/en/setup). |

Gum and GitHub CLI versions are pinned in the script. AI tools and a new OpenClaw
installation follow their official installer defaults. The onboarding guide records
the OpenClaw version, researches it, and pins its configuration work in Phase 2.
No model identifier or provider credential is hardcoded.

## Local paths

| Path | Contents |
|---|---|
| `~/.local/bin/gh` | New GitHub CLI binary. |
| `~/.local/share/ai-studio/openclaw/` | New OpenClaw install and its private Node runtime. |
| `~/.local/share/ai-studio/logs/` | Installation output. Login sessions are not logged. |
| `<studio>/.studio-setup/context.txt` | Detected tool versions and repository commit. No secrets. |
| `<studio>/.studio-setup/start` | Resume launcher with the tool paths and quoted studio directory. |

The script uses a private umask. `.studio-setup/` is ignored by Git. AI guides keep
their own files in their vendor-managed locations. The resume launcher sets its
own PATH, so it works without editing the user's shell profile for OpenClaw or `gh`.

## Verify changes locally

Run `bash -n install.sh`, then try `bash install.sh --preview --plain` and
`bash install.sh --preview` in a real terminal. Preview does not install dependencies,
clone a studio, or launch an AI session. The styled preview downloads Gum temporarily.

Check both guide choices, a folder with spaces, keyboard cancellation, the
numbered fallback, and the piped entry point. Use disposable machines for full
installation checks. Do not install or sign in to AI tools on a development host
just to exercise the UI.

To review a branch end to end, fetch that branch's `install.sh` and set
`STUDIO_REF` to the same branch when running it. The default is `main`.
macOS and Windows/WSL require platform checks before claiming a verified release.
