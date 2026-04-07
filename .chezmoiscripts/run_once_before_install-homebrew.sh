#!/bin/bash

if command -v brew &>/dev/null; then
  echo "Homebrew already installed, skipping."
  exit 0
fi

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
