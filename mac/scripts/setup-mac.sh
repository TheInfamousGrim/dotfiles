#!/bin/bash
# =============================================================================
# Mac Setup Script
# =============================================================================
# This script sets up a new Mac with all the tools and configurations.

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
echo "📦 Setting up Mac from $DOTFILES_DIR"

# ---- Xcode Command Line Tools ----
echo ""
echo "⚙️  Checking Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  echo "  → Installing Xcode Command Line Tools..."
  xcode-select --install
else
  echo "  ✓ Already installed"
fi

# ---- Homebrew ----
echo ""
echo "⚙️  Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "  → Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "  ✓ Homebrew $(brew --version | head -1)"
fi

# ---- Install from Brewfile ----
echo ""
echo "📦 Installing Homebrew packages..."
BREWFILE="$DOTFILES_DIR/Brewfile"
if [ -f "$BREWFILE" ]; then
  brew bundle --file="$BREWFILE"
  echo "  ✓ All packages installed"
else
  echo "  ⚠️  No Brewfile found at $BREWFILE"
fi

# ---- Rust (via rustup) ----
echo ""
echo "⚙️  Setting up Rust..."
if ! command -v rustc &>/dev/null; then
  echo "  → Installing Rust via rustup..."
  rustup-init -y --no-modify-path
  source "$HOME/.cargo/env"
else
  echo "  ✓ Rust $(rustc --version)"
fi

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
  echo "  ✓ Global pnpm packages installed"
fi

# ---- Dotfiles Setup ----
echo ""
echo "🔗 Linking dotfiles..."

# Create ~/.dotfiles symlink
if [ ! -L "$HOME/.dotfiles" ]; then
  ln -sf "$DOTFILES_DIR" "$HOME/.dotfiles"
  echo "  → Created ~/.dotfiles symlink"
fi

# .zshrc
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
  echo "  → Backed up existing .zshrc to .zshrc.backup"
fi
ln -sf "$DOTFILES_DIR/mac/.zshrc" "$HOME/.zshrc"
echo "  → Linked .zshrc"

# .gitconfig
if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
  mv "$HOME/.gitconfig" "$HOME/.gitconfig.backup"
  echo "  → Backed up existing .gitconfig"
fi
ln -sf "$DOTFILES_DIR/shared/.gitconfig" "$HOME/.gitconfig"
echo "  → Linked .gitconfig"

# .gitignore_global
ln -sf "$DOTFILES_DIR/shared/.gitignore_global" "$HOME/.gitignore_global"
echo "  → Linked .gitignore_global"

# .hushlogin (silence login banner)
touch "$HOME/.hushlogin"
echo "  → Created .hushlogin"

# ---- Application Configs ----
echo ""
echo "🔗 Linking application configs..."

# Zed
mkdir -p "$HOME/.config/zed"
mkdir -p "$HOME/.config/zed/themes"
ln -sf "$DOTFILES_DIR/shared/config/zed/settings.json" "$HOME/.config/zed/settings.json"
ln -sf "$DOTFILES_DIR/shared/config/zed/themes/vaporwave-sunset.json" "$HOME/.config/zed/themes/vaporwave-sunset.json"
echo "  → Linked Zed config + Vaporwave theme"

# Ghostty
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/ghostty/themes"
ln -sf "$DOTFILES_DIR/mac/config/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DOTFILES_DIR/mac/config/ghostty/themes/vaporwave-sunset" "$HOME/.config/ghostty/themes/vaporwave-sunset"
echo "  → Linked Ghostty config + vaporwave theme"

# Starship
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/shared/config/starship/starship.toml" "$HOME/.config/starship.toml"
echo "  → Linked Starship config"

# SSH config (skip if exists and not a symlink)
if [ ! -f "$HOME/.ssh/config" ] || [ -L "$HOME/.ssh/config" ]; then
  mkdir -p "$HOME/.ssh"
  ln -sf "$DOTFILES_DIR/mac/ssh/config" "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
  echo "  → Linked SSH config"
else
  echo "  ⚠️  SSH config exists, skipping (merge manually)"
fi

# ---- macOS Defaults ----
echo ""
echo "⚙️  Applying macOS system defaults..."
bash "$DOTFILES_DIR/mac/scripts/macos-defaults.sh"

echo ""
echo "✅ Mac setup complete!"
echo "  → Restart your terminal or run: source ~/.zshrc"
echo "  → Some macOS changes may require a logout/restart"
