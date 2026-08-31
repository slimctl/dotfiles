#!/bin/bash
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

echo "🚢 Applying Dock defaults..."

# Auto-hide the Dock, with no delay and a faster show/hide animation
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15

# No bouncing icon animation when launching apps
defaults write com.apple.dock launchanim -bool false

# Hide the "recent applications" section
defaults write com.apple.dock show-recents -bool false

# Minimize windows into their app's icon instead of a separate Dock icon
defaults write com.apple.dock minimize-to-application -bool true

# Faster "scale" minimize effect instead of the default "genie"
defaults write com.apple.dock mineffect -string "scale"

# Compact icon size
defaults write com.apple.dock tilesize -int 36

killall Dock &>/dev/null || true

echo "✅ Dock defaults applied."
