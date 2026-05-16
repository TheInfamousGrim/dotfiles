# =============================================================================
# Shared ZSH Configuration
# =============================================================================
# This file is sourced by OS-specific .zshrc files.
# Put config here that should work on all platforms.

# ---- History ----
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# ---- Completion ----
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---- Options ----
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt NUMERIC_GLOB_SORT
setopt PROMPT_SUBST

# ---- Plugins ----
# fzf key bindings and fuzzy completion
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# zoxide (smart cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Starship prompt (must be at the end)
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
