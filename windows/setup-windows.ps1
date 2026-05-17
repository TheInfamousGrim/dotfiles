# PowerShell Setup Script for Windows
# =============================================================================
# Run this script to set up a new Windows machine.
# Requires: Windows Terminal, winget (or scoop)
#
# Usage: .\setup-windows.ps1

$ErrorActionPreference = "Stop"
$DotfilesDir = Split-Path -Parent $PSScriptRoot

Write-Host "📦 Setting up Windows from $DotfilesDir" -ForegroundColor Cyan

# ---- Install via winget ----
Write-Host ""
Write-Host "⚙️  Installing packages via winget..." -ForegroundColor Yellow

$WingetPackages = @(
    # Shell & Terminal
    "Microsoft.WindowsTerminal"
    "Git.Git"
    "Microsoft.PowerShell"
    "junegunn.fzf"
    "Starship.Starship"
    "ajeetdsouza.zoxide"
    # Development
    "OpenJS.NodeJS"
    "pnpm.pnpm"
    "Rustlang.Rustup"
    "Docker.DockerDesktop"
    "Kubernetes.kubectl"
    "9P21BVN1Q3T4"  # Zed (via msstore)
    # Applications
    "9P7QZ7FWJNPV"  # Discord (via msstore)
    "Google.Chrome"
    "SlackTechnologies.Slack"
    "Spotify.Spotify"
    "Notion.Notion"
    "Yaak.app"
)

foreach ($pkg in $WingetPackages) {
    Write-Host "  → Installing $pkg..."
    winget install --id $pkg --silent --accept-package-agreements --accept-source-agreements
}

# ---- Install via pnpm ----
Write-Host ""
Write-Host "📦 Installing pnpm global packages..." -ForegroundColor Yellow
pnpm add -g @hubspot/cli @shopify/cli turbo vercel wrangler

# ---- Rust ----
Write-Host ""
Write-Host "⚙️  Setting up Rust..." -ForegroundColor Yellow
if (-not (Get-Command "rustc" -ErrorAction SilentlyContinue)) {
    rustup-init -y --no-modify-path
}

# ---- Dotfiles Setup ----
Write-Host ""
Write-Host "🔗 Setting up dotfiles..." -ForegroundColor Yellow

# Create symlinks (run PowerShell as Admin if needed)
$DotfilesTarget = "$HOME\.dotfiles"
if (-not (Test-Path $DotfilesTarget)) {
    New-Item -ItemType SymbolicLink -Path $DotfilesTarget -Target $DotfilesDir
    Write-Host "  → Created ~\.dotfiles symlink"
}

# .zshrc (for WSL) or profile.ps1 (for PowerShell)
$ZshrcTarget = "$HOME\.zshrc"
if (Test-Path $ZshrcTarget) {
    Move-Item $ZshrcTarget "$ZshrcTarget.backup" -Force
}
New-Item -ItemType SymbolicLink -Path $ZshrcTarget -Target "$DotfilesDir\windows\.zshrc" -Force
Write-Host "  → Linked .zshrc"

# .gitconfig
$GitconfigTarget = "$HOME\.gitconfig"
if (Test-Path $GitconfigTarget) {
    Move-Item $GitconfigTarget "$GitconfigTarget.backup" -Force
}
New-Item -ItemType SymbolicLink -Path $GitconfigTarget -Target "$DotfilesDir\shared\.gitconfig" -Force
Write-Host "  → Linked .gitconfig"

Write-Host ""
Write-Host "✅ Windows setup complete!" -ForegroundColor Green
Write-Host "  → Restart your terminal"
