#!/bin/bash
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

echo "📸 Applying screenshot defaults..."

mkdir -p "${HOME}/Pictures/Screenshots"

# Save to ~/Pictures/Screenshots instead of cluttering the Desktop
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

# PNG format
defaults write com.apple.screencapture type -string "png"

# No drop-shadow around window screenshots
defaults write com.apple.screencapture disable-shadow -bool true

killall SystemUIServer &>/dev/null || true

echo "✅ Screenshot defaults applied."
