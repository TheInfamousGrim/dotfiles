# =============================================================================
# Mac ZSH Configuration
# =============================================================================
# Source shared configs
source "$HOME/.dotfiles/shared/aliases.zsh"
source "$HOME/.dotfiles/shared/exports.zsh"
source "$HOME/.dotfiles/shared/functions.zsh"
source "$HOME/.dotfiles/shared/.zshrc"

# ---- Mac-specific Aliases ----
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias trash="rm -rf ~/.Trash/*"
alias airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
alias cleanup="sudo periodic daily weekly monthly"

# ---- Mac-specific Paths ----
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# ---- Rust (if installed) ----
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# ---- zsh-vi-mode ----
if command -v brew &> /dev/null; then
  ZVM_DIR="$(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode"
  if [ -f "$ZVM_DIR/zsh-vi-mode.plugin.zsh" ]; then
    source "$ZVM_DIR/zsh-vi-mode.plugin.zsh"
  fi
fi

# ---- Bun completions ----
if [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
fi

# ---- Shopify Hydrogen ----
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# THIS MUST REMAIN AT THE END OF THE FILE
# (starship is already initialized in shared/.zshrc)
