#!/bin/bash
# =============================================================================
# Arch Linux Setup Script
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
echo "📦 Setting up Arch Linux from $DOTFILES_DIR"

# ---- Package lists ----
PACMAN_PACKAGES=(
  # Shell & Terminal
  zsh
  fzf
  ripgrep
  starship
  zoxide
  # Development
  git
  nodejs
  npm
  pnpm
  go
  rustup
  python
  python-pip
  docker
  docker-compose
  kubectl
  kubernetes-helm
  # Utils
  unzip
  zip
  curl
  wget
  openssh
  github-cli
  # Fonts
  ttf-fira-code
  ttf-nerd-fonts-symbols
)

AUR_PACKAGES=(
  zed
  ghostty-bin
  opentofu-bin
  azure-cli
  cloudflared
  shopify-cli
  ngrok
  yaak-bin
  visual-studio-code-bin
  raycast
)

# ---- Install packages ----
echo ""
echo "📦 Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"

echo ""
echo "📦 Checking for AUR helper (paru)..."
if ! command -v paru &>/dev/null; then
  echo "  → Installing paru..."
  sudo pacman -S --needed --noconfirm base-devel git
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd "$DOTFILES_DIR"
  rm -rf /tmp/paru
fi

echo ""
echo "📦 Installing AUR packages..."
paru -S --needed --noconfirm "${AUR_PACKAGES[@]}"

# ---- Rust ----
echo ""
echo "⚙️  Setting up Rust..."
if ! command -v rustc &>/dev/null; then
  rustup-init -y --no-modify-path
fi

# ---- Docker ----
echo ""
echo "⚙️  Setting up Docker..."
sudo systemctl enable docker
sudo usermod -aG docker "$USER"
echo "  → Added $USER to docker group (may need logout)"

# ---- PNPM global packages ----
echo ""
echo "📦 Installing pnpm global packages..."
if command -v pnpm &>/dev/null; then
  pnpm add -g \
    @hubspot/cli \
    @shopify/cli \
    turbo \
    vercel \
    wrangler
fi

# ---- Dotfiles ----
echo ""
echo "🔗 Linking dotfiles..."
ln -sf "$DOTFILES_DIR" "$HOME/.dotfiles"
ln -sf "$DOTFILES_DIR/linux/arch/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/shared/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/shared/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/shared/config/starship/starship.toml" "$HOME/.config/starship.toml"
touch "$HOME/.hushlogin"

# Zed
mkdir -p "$HOME/.config/zed/themes"
ln -sf "$DOTFILES_DIR/shared/config/zed/settings.json" "$HOME/.config/zed/settings.json"
ln -sf "$DOTFILES_DIR/shared/config/zed/themes/vaporwave-sunset.json" "$HOME/.config/zed/themes/vaporwave-sunset.json"

echo ""
echo "✅ Arch Linux setup complete!"
echo "  → Restart your terminal or run: source ~/.zshrc"
