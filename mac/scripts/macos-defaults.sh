#!/bin/bash
# =============================================================================
# macOS System Defaults Configuration
# =============================================================================
# Run this script to set macOS system preferences to match your workflow.
# Some changes may require a logout/restart to take effect.

echo "Configuring macOS system preferences..."

# ---- Finder ----
echo "  → Finder settings"
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Show folder first in list view
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Set list view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Avoid creating .DS_Store files on USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ---- Dock ----
echo "  → Dock settings"
# Autohide the Dock
defaults write com.apple.dock autohide -bool true
# Set Dock position to left
defaults write com.apple.dock orientation -string "left"
# Minimize to application
defaults write com.apple.dock minimize-to-application -bool true
# Don't show recent apps in Dock
defaults write com.apple.dock show-recents -bool false
# Set icon size
defaults write com.apple.dock tilesize -int 42
# Enable magnification
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 64

# ---- Trackpad ----
echo "  → Trackpad settings"
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable three-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# ---- Keyboard ----
echo "  → Keyboard settings"
# Set key repeat rate (fast)
defaults write NSGlobalDomain KeyRepeatRate -int 2
# Set initial key repeat (short)
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Disable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ---- Screenshots ----
echo "  → Screenshot settings"
# Save screenshots to Downloads folder
defaults write com.apple.screencapture location -string "$HOME/Downloads"
# Disable screenshot shadows
defaults write com.apple.screencapture disable-shadow -bool true
# Use PNG format
defaults write com.apple.screencapture type -string "png"

# ---- Mission Control ----
echo "  → Mission Control settings"
# Don't rearrange spaces automatically
defaults write com.apple.dock mru-spaces -bool false
# Group windows by application
defaults write com.apple.dock expose-group-by-app -bool true

# ---- App Store ----
echo "  → App Store settings"
# Enable automatic updates
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# ---- Security ----
echo "  → Security settings"
# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on 2>/dev/null || true

# ---- Restart affected apps ----
echo ""
echo "Restarting affected applications..."
for app in "Dock" "Finder" "SystemUIServer"; do
  killall "$app" 2>/dev/null || true
done

echo ""
echo "✓ macOS defaults configured!"
echo "  Some changes may require a logout/restart to fully take effect."
