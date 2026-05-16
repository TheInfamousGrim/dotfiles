#!/bin/bash
# =============================================================================
# Debian/Ubuntu/PopOS Setup Script
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
echo "📦 Setting up Debian/Ubuntu from $DOTFILES_DIR"

# ---- Package lists ----
APT_PACKAGES=(
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
  golang-go
  rustup
  python3
  python3-pip
  python3-venv
  docker.io
  docker-compose-v2
  kubectl
  # Utils
  unzip
  zip
  curl
  wget
  openssh-client
  gh
  build-essential
)

# ---- Install apt packages ----
echo ""
echo "📦 Installing apt packages..."
sudo apt update
sudo apt install -y "${APT_PACKAGES[@]}"

# ---- Install pnpm ----
echo ""
echo "📦 Installing pnpm..."
if ! command -v pnpm &>/dev/null; then
  sudo npm install -g pnpm
fi

# ---- Install Zed ----
echo ""
echo "📦 Installing Zed..."
if ! command -v zed &>/dev/null; then
  curl -fsSL https://zed.dev/install.sh | sh
fi

# ---- Install Ghostty ----
echo ""
echo "📦 Installing Ghostty..."
if ! command -v ghostty &>/dev/null; then
  # Ghostty requires building from source or using a package
  sudo apt install -y libgtk-4-dev libadwaita-1-dev
  git clone https://github.com/ghostty-org/ghostty.git /tmp/ghostty
  cd /tmp/ghostty
  zig build -Doptimize=ReleaseFast
  sudo cp zig-out/bin/ghostty /usr/local/bin/
  cd "$DOTFILES_DIR"
  rm -rf /tmp/ghostty
fi

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

# ---- PNPM global packages ----
if command -v pnpm &>/dev/null; then
  echo "📦 Installing pnpm global packages..."
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
ln -sf "$DOTFILES_DIR/linux/debian/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/shared/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/shared/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/shared/config/starship/starship.toml" "$HOME/.config/starship.toml"
touch "$HOME/.hushlogin"

# Zed
mkdir -p "$HOME/.config/zed/themes"
ln -sf "$DOTFILES_DIR/shared/config/zed/settings.json" "$HOME/.config/zed/settings.json"
ln -sf "$DOTFILES_DIR/shared/config/zed/themes/vaporwave-sunset.json" "$HOME/.config/zed/themes/vaporwave-sunset.json"

echo ""
echo "✅ Debian/Ubuntu setup complete!"
echo "  → Restart your terminal or run: source ~/.zshrc"
