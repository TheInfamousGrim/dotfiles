# dotfiles

🌸 Cross-platform development environment setup.

**Works on:** macOS, Linux (Arch, Debian, Ubuntu, Pop!_OS), Windows (WSL)

## Quick Start

### Fresh machine (one-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/georgefincher/dotfiles/main/bootstrap.sh | bash
```

### Already cloned

```bash
cd ~/Coding/personal/dotfiles
./bootstrap.sh
```

The bootstrap script will:
1. Detect your OS automatically
2. Install package managers (Homebrew, pacman, apt, winget)
3. Install all your tools and applications
4. Symlink dotfiles to the right locations
5. Apply OS-specific system preferences

---

## Structure

```
dotfiles/
├── bootstrap.sh                 # Main entry point (OS detection)
├── Brewfile                     # Homebrew packages (macOS)
├── LICENSE                      # MIT License
├── README.md                    # You are here
│
├── shared/                      # Cross-platform configs
│   ├── .gitconfig               # Shared git configuration
│   ├── .gitignore_global        # Global gitignore rules
│   ├── .zshrc                   # Core zsh config (sourced by OS zshrc)
│   ├── aliases.zsh              # Shared aliases (git, docker, k8s, etc.)
│   ├── exports.zsh              # Shared environment variables (PATH, EDITOR)
│   ├── functions.zsh            # Shared shell functions
│   └── config/
│       ├── starship/starship.toml    # Starship prompt (Vaporwave theme)
│       └── zed/themes/
│           └── vaporwave-sunset.json # Zed theme
│
├── mac/                         # macOS-specific
│   ├── .zshrc                   # Mac zsh config (sources shared/)
│   ├── config/
│   │   ├── zed/
│   │   │   ├── settings.json    # Zed editor settings
│   │   │   └── themes/
│   │   │       └── vaporwave-sunset.json
│   │   └── ghostty/config       # Ghostty terminal config
│   ├── ssh/config               # SSH config template
│   └── scripts/
│       ├── setup-mac.sh         # Full Mac setup script
│       └── macos-defaults.sh    # macOS system preferences
│
├── linux/                       # Linux-specific
│   ├── arch/
│   │   ├── .zshrc               # Arch zsh config
│   │   └── setup-arch.sh        # Arch setup script
│   └── debian/
│       ├── .zshrc               # Debian/Ubuntu/Pop zsh config
│       └── setup-debian.sh      # Debian setup script
│
└── windows/                     # Windows/WSL-specific
    ├── .zshrc                   # WSL zsh config
    └── setup-windows.ps1        # Windows setup script (PowerShell)
```

## What Gets Installed

### macOS (`setup-mac.sh` + `Brewfile`)
- **Package manager:** Homebrew
- **Shell:** ZSH with zsh-vi-mode, Starship prompt
- **Editors:** Zed (with Vaporwave Sunset theme + DeepSeek agent config)
- **Terminal:** Ghostty (with Vaporwave-inspired config)
- **CLI tools:** git, fzf, ripgrep, zoxide, bat, eza, fd, delta, lazygit
- **Dev tools:** Node.js, pnpm, Go, Rust, Docker, kubectl, OpenTofu
- **Cloud:** Azure CLI, Cloudflare CLI, Shopify CLI, Fly.io CLI, Railway CLI
- **Apps:** Raycast, Chrome, Discord, Slack, Spotify, Notion, Linear, TablePlus
- **PNPM globals:** @hubspot/cli, @shopify/cli, turbo, vercel, wrangler

### Arch Linux (`setup-arch.sh`)
- **Package manager:** pacman + paru (AUR)
- Same toolset adapted for Arch packages + AUR

### Debian/Ubuntu/Pop!_OS (`setup-debian.sh`)
- **Package manager:** apt
- Same toolset adapted for Debian-based distros

### Windows (`setup-windows.ps1`)
- **Package manager:** winget
- For WSL usage with zsh

## Themes Included

### Vaporwave Sunset (Zed)
A custom dark theme featuring:
- **Background:** Deep purple/black (#0d0221)
- **Accents:** Neon pink (#ff00ff), cyan (#00f0ff), green (#39ff14)
- **Syntax:** Clean, high-contrast vaporwave aesthetic
- **Terminal ANSI:** Fully themed terminal colors
- **Multiplayer cursors:** 8 coordinated player colors

The theme file is at:
- `shared/config/zed/themes/vaporwave-sunset.json`

### Starship Prompt
A vaporwave-inspired prompt showing:
- OS icon · username · directory · git status
- Node/pnpm/Go/Rust/Python versions
- Docker/Kubernetes/Terraform context
- Time · vim-mode indicator

## Manual Setup

If you prefer to set things up manually:

1. Clone the repo
2. Symlink what you need:

```bash
# Link the whole repo
ln -sf ~/Coding/personal/dotfiles ~/.dotfiles

# Shell config
ln -sf ~/.dotfiles/mac/.zshrc ~/.zshrc

# Git
ln -sf ~/.dotfiles/shared/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/shared/.gitignore_global ~/.gitignore_global

# Zed
mkdir -p ~/.config/zed/themes
ln -sf ~/.dotfiles/shared/config/zed/settings.json ~/.config/zed/settings.json
ln -sf ~/.dotfiles/shared/config/zed/themes/vaporwave-sunset.json ~/.config/zed/themes/

# Ghostty
mkdir -p ~/.config/ghostty
ln -sf ~/.dotfiles/mac/config/ghostty/config ~/.config/ghostty/config

# Starship
ln -sf ~/.dotfiles/shared/config/starship/starship.toml ~/.config/starship.toml
```

## License

MIT
