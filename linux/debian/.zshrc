# =============================================================================
# Debian/Ubuntu/PopOS ZSH Configuration
# =============================================================================
# Source shared configs
source "$HOME/.dotfiles/shared/aliases.zsh"
source "$HOME/.dotfiles/shared/exports.zsh"
source "$HOME/.dotfiles/shared/functions.zsh"
source "$HOME/.dotfiles/shared/.zshrc"

# ---- Debian-specific Aliases ----
alias update="sudo apt update && sudo apt upgrade -y"
alias install="sudo apt install"
alias remove="sudo apt remove"
alias search="apt search"
alias cleanup="sudo apt autoremove -y && sudo apt autoclean"
alias ppa="sudo add-apt-repository"

# ---- Debian-specific Paths ----
export PATH="$HOME/.local/bin:$PATH"

# ---- Rust ----
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# ---- fd-find is named 'fdfind' on Debian ----
if command -v fdfind &>/dev/null; then
  alias fd="fdfind"
fi

# ---- bat is named 'batcat' on Debian ----
if command -v batcat &>/dev/null; then
  alias bat="batcat"
fi
