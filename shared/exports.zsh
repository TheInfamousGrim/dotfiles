# =============================================================================
# Shared Environment Variables
# =============================================================================

# ---- Editor ----
export EDITOR="zed --wait"
export VISUAL="$EDITOR"

# ---- Language/Dev ----
export PNPM_HOME="$HOME/Library/pnpm"
export BUN_INSTALL="$HOME/.bun"
export GOPATH="$HOME/go"

# ---- PATH ----
# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Go
export PATH="$GOPATH/bin:$PATH"

# PNPM
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Bun
export PATH="$BUN_INSTALL/bin:$PATH"

# Homebrew (Apple Silicon)
if [[ $(uname -m) == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ---- Temp ----
export TMPDIR=/tmp

# ---- Man pages ----
export MANPATH="/opt/homebrew/share/man:$MANPATH"

# ---- Less ----
export LESS="-R"
export LESSOPEN="|/usr/bin/lesspipe.sh %s 2>/dev/null"

# ---- Misc ----
export FIGNORE=".o:.pyc:.swp"
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"
