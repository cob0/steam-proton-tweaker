#!/usr/bin/env bash

required_packages=("protontricks")

if command -v pipx &> /dev/null; then
  echo "[✓] OK: pipx package is already installed."
else
  echo "[>] INFO: pipx package is not installed. We are trying install it."
  python3 -m pip install --user pipx &> /dev/null || exit
  python3 -m pipx ensurepath &> /dev/null || exit
fi

installed_packages=$(python3 -m pipx list --short)

if [ -z "$installed_packages" ]; then
  echo "[>] INFO: No packages are currently installed. Installing required packages..."
  for package in "${required_packages[@]}"; do
    echo "[>] INFO: Installing $package package."
    python3 -m pipx install "$package" &> /dev/null
  done
else
  for package in "${required_packages[@]}"; do
    package_installed=$(echo "$installed_packages" | grep -E "^$package [0-9]+\.[0-9]+\.[0-9]+$")
    if [ -n "$package_installed" ]; then
      echo "[✓] OK: $package_installed package is already installed."
      python3 -m pipx upgrade "$package" &> /dev/null
    else
      echo "[>] INFO: $package package is not installed. We are trying to install it."
      python3 -m pipx install "$package" &> /dev/null
    fi
  done
fi

echo "[✓] OK: $0 executed."