#!/usr/bin/env bash

is_steam_running() {
    pgrep -x "steam" > /dev/null
    return $?
}

if ! sh scripts/dnf-install-required-packages.sh; then
  echo "[x] ERROR: dnf-install-required-packages.sh execution failed."
  exit 1
fi

if ! sh scripts/pipx-install-required-packages.sh; then
  echo "[x] ERROR: pipx-install-required-packages.sh execution failed."
  exit 1
fi

if ! sh scripts/install-steam-cmd.sh; then
  echo "[x] ERROR: install-steam-cmd.sh execution failed."
  exit 1
fi

if ! is_steam_running; then
    echo "[!] WARN: Steam is not running. We are trying to run steam..."
    steam > /dev/null 2>&1 &
    echo "[>] INFO: waiting 10 seconds until Steam is running"
    sleep 10
    if ! is_steam_running; then
      echo "[x] ERROR: Steam failed to start. Please start Steam manually and try again."
      exit 1
    fi
fi

read -rp "enter your Steam username: " username
read -rsp "enter your Steam password: " password

echo "[>] INFO: executing SteamCMD..."
if ! tmp/steamcmd/steamcmd.sh -debug +login "$username" "$password" +app_update 65540 -beta workshop validate +quit; then
  echo "[x] ERROR: SteamCMD execution failed."
  exit 1
fi

if ! sh scripts/cleanup-environment.sh; then
  echo "[x] ERROR: cleanup-environment.sh execution failed."
  exit 1
fi

echo "[✓] OK: $0 executed."