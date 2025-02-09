#!/usr/bin/env bash

required_packages=("glibc.i686" "libstdc++.i686" "python3-pip" "python3-setuptools" "python3-libs")

run_with_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "[!] WARN: This script requires sudo to run. Elevating privileges..."
        sudo "$0" "$@"
        exit 0
    fi
}

run_with_sudo "$0"

echo "[>] INFO: Executing commands with elevated privileges..."
for package in "${required_packages[@]}" ; do
  # verifying that you have installed all required packages
  if dnf list installed "$package" &> /dev/null; then
      echo "[✓] OK: '$package' package is already installed."
  else
      echo "[>] INFO: '$package' package is not installed. We are trying install it."
      dnf install -y "$package"
  fi
done

echo "[✓] OK: $0 executed. Exiting with elevated privileges."