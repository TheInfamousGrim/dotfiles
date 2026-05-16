# =============================================================================
# Arch Linux ZSH Configuration
# =============================================================================
# Source shared configs
source "$HOME/.dotfiles/shared/aliases.zsh"
source "$HOME/.dotfiles/shared/exports.zsh"
source "$HOME/.dotfiles/shared/functions.zsh"
source "$HOME/.dotfiles/shared/.zshrc"

# ---- Arch-specific Aliases ----
alias update="sudo pacman -Syu"
alias install="sudo pacman -S"
alias remove="sudo pacman -Rns"
alias search="pacman -Ss"
alias aur-update="paru -Syu"
alias aur-install="paru -S"
alias cleanup="sudo pacman -Sc && paru -Sc"
alias orphans="pacman -Qdt"
alias remove-orphans="sudo pacman -Rns $(pacman -Qdtq)"

# ---- Arch-specific Paths ----
export PATH="$HOME/.local/bin:$PATH"

# ---- Rust ----
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi
