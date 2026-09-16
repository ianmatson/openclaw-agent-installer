#!/usr/bin/env bash
# Keep this file standalone: the public entry point must work before Git or Node exists.
# Compatible with the Bash 3.2 shipped with macOS.
set -Eeuo pipefail
umask 077

REPO_URL=https://github.com/ianmatson/openclaw-agent-installer.git
REPO_REF=${STUDIO_REF:-main}
GUM_VERSION=2.0.1
GH_VERSION=2.101.0
TOOLS="$HOME/.local/share/ai-studio"
BIN="$HOME/.local/bin"
CLAW_PREFIX="$TOOLS/openclaw"
export PATH="$BIN:$CLAW_PREFIX/bin:$PATH"
WORK=''
STAGE=''
GUM=''
LOG=''
DEST=''
ASSISTANT=''
PLAIN=${STUDIO_PLAIN:-0}
PREVIEW=0
NO_LAUNCH=0

say() { printf '%s\n' "$*"; }
die() { printf '\n  Setup paused: %s\n' "$*" >&2; exit 1; }
cancel() { say ''; say '  Setup stopped. Run the same command when you are ready.'; exit 130; }
cleanup() {
  [[ -z "$STAGE" ]] || rm -rf -- "$STAGE"
  [[ -z "$WORK" ]] || rm -rf -- "$WORK"
  return 0
}
# shellcheck disable=SC2329 # Invoked by the ERR trap.
on_error() {
  trap - ERR
  printf '\n  Setup could not finish. Your existing studio files are still in place.\n' >&2
  [[ -z "$LOG" ]] || printf '  Details: %s\n' "$LOG" >&2
  printf '  Fix the reported problem, then run the installer again.\n' >&2
  exit 1
}
trap cleanup EXIT
trap cancel INT TERM
trap on_error ERR

usage() {
  cat <<'EOF'
Your AI Studio — guided setup

  bash install.sh                 Start the guided installer
  bash install.sh --preview       Explore the flow without installing tools or creating a studio
  bash install.sh --plain         Use numbered prompts without color or animation
  bash install.sh --no-launch     Install tools and prepare the studio, then stop

Requires macOS or Linux (including Ubuntu on WSL2), Bash, curl, and a terminal.
The preview may download a temporary, checksum-verified Gum UI binary.
Use --preview --plain for a preview with no downloads or file changes.
STUDIO_REF selects the repository branch or tag to clone (default: main).
EOF
}

fetch() {
  curl --fail --silent --show-error --location --proto '=https' --tlsv1.2 \
    --connect-timeout 15 --max-time "${3:-600}" --retry 2 "$1" -o "$2"
}
export -f fetch

verify_archive() {
  local archive=$1 checksums=$2 expected actual
  expected=$(awk -v name="${archive##*/}" '$2 == name || $2 == "*" name {print $1}' "$checksums")
  [[ ${#expected} -eq 64 ]] || return 1
  if command -v sha256sum >/dev/null 2>&1; then
    actual=$(sha256sum "$archive")
  else
    actual=$(shasum -a 256 "$archive")
  fi
  [[ ${actual%% *} == "$expected" ]]
}

bootstrap_ui() {
  [[ "$PLAIN" == 0 ]] || return 0
  WORK=$(mktemp -d "${TMPDIR:-/tmp}/ai-studio.XXXXXXXX")
  local asset="gum_${GUM_VERSION}_${OS}_${GUM_ARCH}.tar.gz"
  local base="https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}"
  say '  Preparing your setup guide…'
  if fetch "$base/$asset" "$WORK/$asset" 45 &&
     fetch "$base/checksums.txt" "$WORK/checksums.txt" 30 &&
     verify_archive "$WORK/$asset" "$WORK/checksums.txt" &&
     tar --no-same-owner -xzf "$WORK/$asset" -C "$WORK"; then
    GUM="$WORK/gum_${GUM_VERSION}_${OS}_${GUM_ARCH}/gum"
    # Release archives may use either a top-level directory or a flat layout.
    [[ -x "$GUM" ]] || GUM="$WORK/gum"
    if [[ -x "$GUM" ]] && "$GUM" --version >/dev/null 2>&1; then
      export GUM_CHOOSE_CURSOR_FOREGROUND=212 GUM_CHOOSE_SELECTED_FOREGROUND=212
      export GUM_INPUT_CURSOR_FOREGROUND=212 GUM_CONFIRM_SELECTED_BACKGROUND=212
      return 0
    fi
  fi
  GUM=''
  say '  The animated guide is unavailable. Continuing with numbered choices.'
}

heading() {
  say ''
  if [[ -n "$GUM" ]]; then
    "$GUM" style --foreground 212 --bold "$1"
    "$GUM" style --foreground 245 "$2"
  else
    say "  $1"
    say "  $2"
  fi
  say ''
}

choose() {
  local title=$1 result index=1 option
  shift
  if [[ -n "$GUM" ]]; then
    "$GUM" choose --header "$title" --cursor '› ' "$@" || return 130
  else
    printf '  %s\n' "$title" >&2
    for option in "$@"; do
      printf '  %s. %s\n' "$index" "$option" >&2
      index=$((index + 1))
    done
    while true; do
      printf '  Enter a number [1]: ' >&2
      IFS= read -r result || return 130
      result=${result:-1}
      case "$result" in *[!0-9]*|'') continue ;; esac
      # Compare as strings to avoid octal parsing and oversized integer input.
      index=1
      for option in "$@"; do
        if [[ "$result" == "$index" ]]; then printf '%s\n' "$option"; return 0; fi
        index=$((index + 1))
      done
    done
  fi
}

confirm() {
  local answer
  if [[ -n "$GUM" ]]; then
    "$GUM" confirm --default=false --affirmative 'Continue' --negative 'Not now' "$1"
  else
    printf '  %s [y/N]: ' "$1"
    IFS= read -r answer || return 1
    [[ "$answer" == y || "$answer" == Y || "$answer" == yes ]]
  fi
}

input_path() {
  if [[ -n "$GUM" ]]; then
    "$GUM" input --header 'Where should your studio live?' --value "$HOME/ai-studio" || return 130
  else
    printf '  Studio folder [%s/ai-studio]: ' "$HOME" >&2
    IFS= read -r REPLY || return 130
    printf '%s\n' "${REPLY:-$HOME/ai-studio}"
  fi
}

# Background work never reads input. Login and package-manager prompts run in the foreground.
run_task() {
  local title=$1 status=0
  shift
  printf '\n--- %s ---\n' "$title" >> "$LOG"
  if [[ -n "$GUM" ]]; then
    export STUDIO_LOG="$LOG"
    # shellcheck disable=SC2016 # Expand the arguments and log path in the child shell.
    "$GUM" spin --spinner dot --title "$title" -- \
      bash -c '"$@" >>"$STUDIO_LOG" 2>&1' _ "$@" || status=$?
  else
    say "  … $title"
    "$@" >> "$LOG" 2>&1 || status=$?
  fi
  if [[ "$status" != 0 ]]; then
    printf '\n  Could not finish: %s\n' "$title" >&2
    tail -n 12 "$LOG" >&2
    die "See $LOG. Run the installer again after fixing the issue."
  fi
  say "  ✓ $title"
}

available() {
  command -v "$1" >/dev/null 2>&1 || return 1
  # Apple's Git shim can open an installation dialog, even for --version.
  if [[ "$1" == git && "$OS" == Darwin && "$(command -v git)" == /usr/bin/git ]]; then
    xcode-select -p >/dev/null 2>&1 || return 1
  fi
  "$1" --version >/dev/null 2>&1
}
plan_tool() {
  if available "$1"; then printf '  ✓ Keep %-14s %s\n' "$2" "$3";
  else printf '  + Add  %-14s %s\n' "$2" "$3"; fi
}

ensure_git() {
  available git && return 0
  say '  Git downloads your studio files. Its installer may ask for your computer password.'
  if [[ "$OS" == Darwin ]]; then
    say '  Apple will open a window. Choose Install, then return here when it finishes.'
    xcode-select --install || true
    confirm 'Have the Apple command line tools finished installing?' || cancel
  else
    command -v sudo >/dev/null 2>&1 || die 'Ask your administrator to install Git, then run this command again.'
    if command -v apt-get >/dev/null 2>&1; then
      sudo apt-get update
      sudo apt-get install -y git
    elif command -v dnf >/dev/null 2>&1; then sudo dnf install -y git
    elif command -v yum >/dev/null 2>&1; then sudo yum install -y git
    elif command -v pacman >/dev/null 2>&1; then sudo pacman -S --needed --noconfirm git
    else die 'Install Git with your Linux package manager, then run this command again.'; fi
  fi
  available git || die 'Git is not ready yet. Finish its installation, then run this command again.'
}

ensure_gh() {
  available gh && return 0
  local platform=linux extension=tar.gz asset base folder
  if [[ "$OS" == Darwin ]]; then
    platform=macOS
    extension=zip
    command -v unzip >/dev/null 2>&1 || die 'The macOS unzip command is missing.'
  fi
  folder="gh_${GH_VERSION}_${platform}_${GH_ARCH}"
  asset="$folder.$extension"
  base="https://github.com/cli/cli/releases/download/v${GH_VERSION}"
  run_task 'Downloading GitHub CLI' fetch "$base/$asset" "$WORK/$asset"
  fetch "$base/gh_${GH_VERSION}_checksums.txt" "$WORK/gh-checksums.txt"
  verify_archive "$WORK/$asset" "$WORK/gh-checksums.txt" || die 'GitHub CLI download failed its checksum check. Please try again.'
  if [[ "$extension" == zip ]]; then unzip -q "$WORK/$asset" -d "$WORK";
  else tar --no-same-owner -xzf "$WORK/$asset" -C "$WORK"; fi
  install -m 755 "$WORK/$folder/bin/gh" "$BIN/gh"
  available gh || die 'GitHub CLI could not start on this computer.'
}

ensure_openclaw() {
  available openclaw && return 0
  # Do not send a pre-existing installation through upstream's upgrade/service-repair path.
  [[ ! -e "$CLAW_PREFIX/bin/openclaw" ]] || die "An existing OpenClaw installation needs repair at $CLAW_PREFIX. Ask your setup guide to repair it."
  command -v openclaw >/dev/null 2>&1 && die 'An existing OpenClaw command could not start. Repair it before continuing.'
  run_task 'Downloading the OpenClaw installer' fetch https://openclaw.ai/install-cli.sh "$WORK/openclaw-install.sh"
  run_task 'Installing OpenClaw and its private Node runtime' \
    bash "$WORK/openclaw-install.sh" --prefix "$CLAW_PREFIX" --no-onboard
  available openclaw || die 'OpenClaw installed but could not start. See the setup log.'
}

ensure_assistant() {
  available "$ASSISTANT" && return 0
  if [[ "$ASSISTANT" == codex ]]; then
    run_task 'Downloading the Codex installer' fetch https://chatgpt.com/codex/install.sh "$WORK/assistant-install.sh"
    run_task 'Installing Codex' env CODEX_NON_INTERACTIVE=1 sh "$WORK/assistant-install.sh"
  else
    run_task 'Downloading the Claude Code installer' fetch https://claude.ai/install.sh "$WORK/assistant-install.sh"
    run_task 'Installing Claude Code' bash "$WORK/assistant-install.sh"
  fi
  hash -r
  available "$ASSISTANT" || die 'Your guide installed but could not start. See the setup log.'
}

validate_destination() {
  # shellcheck disable=SC2088 # Match a literal tilde supplied through the input prompt.
  case "$DEST" in
    '~') DEST="$HOME" ;;
    '~/'*) DEST="$HOME/${DEST#\~/}" ;;
  esac
  [[ "$DEST" == /* && "$DEST" != / && "$DEST" != "$HOME" ]] || die 'Choose a full folder path, such as ~/ai-studio, below your home folder.'
  [[ "$DEST" != *$'\n'* && "$DEST" != *$'\r'* ]] || die 'The folder path must fit on one line.'
  if [[ -e "$DEST" || -L "$DEST" ]]; then
    [[ -d "$DEST/.git" && -f "$DEST/AGENTS.md" && -f "$DEST/process/00-orient.md" ]] ||
      die 'That folder already exists and is not a studio checkout. Choose a new folder.'
    local origin
    origin=$(git -C "$DEST" remote get-url origin 2>/dev/null) || die 'Cannot identify this existing studio checkout.'
    case "$origin" in
      "$REPO_URL"|"${REPO_URL%.git}"|git@github.com:ianmatson/openclaw-agent-installer.git) ;;
      *) die 'That folder belongs to another repository. Choose a new folder.' ;;
    esac
    say '  Found your existing studio. Setup will keep its files and current version.'
  fi
}

prepare_studio() {
  if [[ ! -e "$DEST" ]]; then
    # Clone beside the destination, then rename, so an interrupted clone is recoverable.
    local parent
    parent=$(dirname "$DEST")
    mkdir -p "$parent"
    STAGE=$(mktemp -d "$parent/.ai-studio-download.XXXXXXXX")
    run_task 'Downloading your studio' git clone --depth 1 --branch "$REPO_REF" "$REPO_URL" "$STAGE"
    [[ ! -e "$DEST" ]] || die 'The destination appeared during download. Choose another folder.'
    mv "$STAGE" "$DEST"
    STAGE=''
  fi
  # Local state is deliberately ignored. Never store credentials or full environment dumps.
  # Older checkouts may not have the new .gitignore entry yet.
  local exclude
  exclude=$(cd "$DEST" && git rev-parse --git-path info/exclude)
  [[ "$exclude" == /* ]] || exclude="$DEST/$exclude"
  mkdir -p "$(dirname "$exclude")"
  if ! grep -qxF '/.studio-setup/' "$exclude" 2>/dev/null; then
    printf '\n/.studio-setup/\n' >> "$exclude"
  fi
  mkdir -p "$DEST/.studio-setup"
  {
    printf 'Guide: %s\nPlatform: %s\n' "$ASSISTANT" "$OS"
    printf 'OpenClaw: '; openclaw --version
    printf 'GitHub CLI: '; gh --version | head -n 1
    printf 'Guide version: '; "$ASSISTANT" --version
    printf 'Repository commit: '; git -C "$DEST" rev-parse HEAD
    printf '\nTools are installed. Account sign-in and studio activation still need verification.\n'
  } > "$DEST/.studio-setup/context.txt"
  {
    printf '#!/usr/bin/env bash\nset -e\n'
    # shellcheck disable=SC2016 # The launcher must expand PATH when it runs.
    printf 'export PATH=%q:"$PATH"\n' "$BIN:$CLAW_PREFIX/bin"
    printf 'cd %q\n' "$DEST"
    printf 'exec %q %q\n' "$ASSISTANT" 'Begin onboarding. Read AGENTS.md and .studio-setup/context.txt first. Verify installed tools, then guide me through the phases. If studio files already exist, ask where I stopped before changing them.'
  } > "$DEST/.studio-setup/start"
  chmod 700 "$DEST/.studio-setup/start"
}

main() {
  local arg selection launch
  for arg in "$@"; do
    case "$arg" in
      --help|-h) usage; return ;;
      --plain) PLAIN=1 ;;
      --preview) PREVIEW=1 ;;
      --no-launch) NO_LAUNCH=1 ;;
      *) die "Unknown option: $arg. Use --help for options." ;;
    esac
  done
  # Read the entire script before attaching stdin to the terminal (see invocation at EOF).
  [[ -t 1 ]] || die 'Open Terminal and run this command there. An interactive terminal is required.'
  [[ -t 0 ]] || exec </dev/tty
  OS=$(uname -s)
  case "$OS" in Darwin|Linux) ;; *) die 'On Windows, open Ubuntu in WSL2 and run this command there. See the README.' ;; esac
  case "$(uname -m)" in
    x86_64|amd64) GUM_ARCH=x86_64; GH_ARCH=amd64 ;;
    arm64|aarch64) GUM_ARCH=arm64; GH_ARCH=arm64 ;;
    *) die 'This installer supports 64-bit Intel/AMD and ARM computers.' ;;
  esac
  if [[ "$OS" == Linux ]] && compgen -G '/lib/ld-musl-*' >/dev/null; then
    die 'Use a glibc-based Linux distribution, such as Ubuntu. Alpine is not supported by this installer.'
  fi
  [[ "$PREVIEW" == 1 || "$EUID" != 0 ]] || die 'Run this as your normal user, without sudo. Setup asks for a password only if Git needs it.'
  command -v curl >/dev/null 2>&1 || die 'Install curl with your system package manager, then try again.'
  [[ -z "${NO_COLOR:-}" && "${TERM:-dumb}" != dumb ]] || PLAIN=1
  bootstrap_ui
  heading 'YOUR AI STUDIO' 'One setup. Your own team of AI agents.'
  say '  We will prepare the tools, then your AI guide will help build your team.'
  say '  Use a computer that can stay on. You can explore on a laptop first.'
  [[ "$PREVIEW" == 0 ]] || say '  PREVIEW — no tools will be installed and no studio files will be created.'

  heading '01 / 05  Choose your guide' 'Pick the account you already use. Both guides follow the same setup.'
  say '  Codex        Sign in with an eligible ChatGPT account or OpenAI API access.'
  say '  Claude Code  Sign in with an eligible Claude account or Anthropic API access.'
  say '  API usage is billed separately. This choice does not lock your studio to a provider.'
  say ''
  selection=$(choose 'Which guide would you like?' 'Codex — I use ChatGPT / OpenAI' 'Claude Code — I use Claude / Anthropic') || cancel
  case "$selection" in Codex*) ASSISTANT=codex ;; *) ASSISTANT=claude ;; esac

  heading '02 / 05  Give your studio a home' 'This folder holds your team, documents, and configuration.'
  DEST=$(input_path) || cancel
  validate_destination

  heading '03 / 05  Your setup plan' 'Keep what works. Install what is missing.'
  plan_tool "$ASSISTANT" "$ASSISTANT" 'Your guide through studio setup'
  plan_tool git Git 'Downloads and tracks your studio files'
  plan_tool gh 'GitHub CLI' 'Connects to GitHub when you want to save your work'
  plan_tool openclaw OpenClaw 'Runs your AI team, with a private Node runtime if needed'
  say "  Studio folder: $DEST"
  say ''
  say '  New tools use official downloads. Git may require your computer password.'
  say '  Tools live in your user account. Vendor installers may add their commands to your shell.'
  say '  You will sign in directly with your guide. No passwords or API keys are collected here.'
  if [[ "$PREVIEW" == 1 ]]; then
    heading '04 / 05  Install and check' 'Preview: real setup shows an animated status for each download and installation.'
    heading '05 / 05  Meet your guide' 'Preview: sign in, describe your work, then build and connect your team together.'
    say '  Run again without --preview to set up your studio.'
    return
  fi
  confirm 'Install the missing tools and prepare this folder?' || cancel
  [[ -n "$WORK" ]] || WORK=$(mktemp -d "${TMPDIR:-/tmp}/ai-studio.XXXXXXXX")
  mkdir -p "$TOOLS/logs" "$BIN"
  LOG=$(mktemp "$TOOLS/logs/setup.log.XXXXXXXX")
  heading '04 / 05  Getting everything ready' 'This can take several minutes. Completed tools are reused if you return later.'
  ensure_git
  ensure_gh
  ensure_openclaw
  ensure_assistant
  say '  Preparing your studio folder…'
  prepare_studio

  heading '05 / 05  Meet your guide' 'Tools are ready. Next comes your team.'
  say '  Your guide will ask you to sign in, learn about your work, and design your team.'
  say '  It will explain model costs and walk you through the required Discord browser steps.'
  say '  GitHub sign-in can wait until you want to save to your own private repository.'
  say ''
  say '  To return to this studio, run:'
  printf '    bash %q\n' "$DEST/.studio-setup/start"
  say ''
  [[ "$NO_LAUNCH" == 0 ]] || return 0
  launch=$(choose 'Ready for the next step?' 'Begin onboarding — sign in and build my team' 'Finish for now — use the command above later') || cancel
  case "$launch" in
    Begin*)
      cleanup
      WORK=''
      # The vendor CLI owns sign-in. Never log, intercept, or weaken its permission prompts.
      bash "$DEST/.studio-setup/start" || die 'Your guide exited before finishing. Use the return command above to try again.'
      ;;
  esac
}

# A compound command is fully parsed before execution. This keeps curl | bash safe
# when main reconnects stdin to /dev/tty for arrow-key prompts and the AI session.
{ main "$@"; exit $?; }
