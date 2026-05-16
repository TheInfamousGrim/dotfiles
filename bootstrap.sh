#!/bin/bash
# =============================================================================
# Dotfiles Bootstrap Script
# =============================================================================
# One script to rule them all. Detects your OS and runs the appropriate setup.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/TheInfamousGrim/dotfiles/main/bootstrap.sh | bash
#   # OR if already cloned:
#   ./bootstrap.sh

set -e

REPO_URL="https://github.com/TheInfamousGrim/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "╭──────────────────────────────────────╮"
echo "│  🌸  Dotfiles Bootstrap  🌸          │"
echo "╰──────────────────────────────────────╯"
echo ""

# ---- Clone if not already present ----
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "📁 Cloning dotfiles repository..."
  git clone "$REPO_URL" "$DOTFILES_DIR"
else
  echo "📁 Dotfiles directory already exists, pulling latest..."
  cd "$DOTFILES_DIR" && git pull
fi

cd "$DOTFILES_DIR"

# ---- Detect OS ----
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "🖥️  Detected: $OS ($ARCH)"
echo ""

case "$OS" in
  Darwin)
    echo "🍎 macOS detected — running Mac setup..."
    bash "$DOTFILES_DIR/mac/scripts/setup-mac.sh"
    ;;

  Linux)
    # Detect Linux distro
    if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
      echo "🐧 Arch Linux detected — running Arch setup..."
      bash "$DOTFILES_DIR/linux/arch/setup-arch.sh"
    elif [ -f /etc/debian_version ] || [ -f /etc/os-release ] && grep -qi "ubuntu\|pop\|debian" /etc/os-release 2>/dev/null; then
      echo "🐧 Debian/Ubuntu/Pop!_OS detected — running Debian setup..."
      bash "$DOTFILES_DIR/linux/debian/setup-debian.sh"
    else
      echo "❌ Unsupported Linux distribution."
      echo "   Currently supported: Arch, Manjaro, Debian, Ubuntu, Pop!_OS"
      echo "   You can manually run the closest matching setup script."
      exit 1
    fi
    ;;

  *)
    echo "❌ Unsupported operating system: $OS"
    echo "   Currently supported: macOS, Linux (Arch/Debian/Ubuntu/Pop!_OS)"
    exit 1
    ;;
esac

echo ""
echo "╭──────────────────────────────────────╮"
echo "│  ✅  Bootstrap Complete! 🌸           │"
echo "│                                       │"
echo "│  Restart your terminal to apply       │"
echo "│  all changes:                         │"
echo "│    exec \$SHELL -l                     │"
echo "╰──────────────────────────────────────╯"
