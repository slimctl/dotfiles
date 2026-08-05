#!/bin/bash
set -euo pipefail

if command -v brew &>/dev/null; then
  echo "🍺 Homebrew already installed, skipping."
  exit 0
fi

echo "🍺 Installing Homebrew..."
installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
if [ -z "$installer" ]; then
  echo "❌ Failed to download Homebrew installer" >&2
  exit 1
fi
/bin/bash -c "$installer"
