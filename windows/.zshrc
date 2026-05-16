# =============================================================================
# Windows (WSL) ZSH Configuration
# =============================================================================
# This is used when running ZSH inside WSL on Windows.
# Source shared configs
source "$HOME/.dotfiles/shared/aliases.zsh"
source "$HOME/.dotfiles/shared/exports.zsh"
source "$HOME/.dotfiles/shared/functions.zsh"
source "$HOME/.dotfiles/shared/.zshrc"

# ---- Windows/WSL-specific Aliases ----
alias pbcopy="/mnt/c/Windows/System32/clip.exe"
alias pbpaste="powershell.exe -Command 'Get-Clipboard'"
alias open="explorer.exe"
alias chrome="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe"

# ---- Windows/WSL-specific Paths ----
export PATH="$HOME/.local/bin:$PATH"

# ---- Rust ----
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi
