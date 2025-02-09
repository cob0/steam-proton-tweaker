#!/usr/bin/env bash

steam_cmd_folder="./tmp/steamcmd"
steam_cmd_latest_version_url="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
steam_cmd_file="steam-cmd-latest-version.tar.gz"

if [ -d "$steam_cmd_folder" ]; then
  echo "[!] WARN: Cleaning up environment..."
  rm -rf "$steam_cmd_folder"
fi

echo "[>] INFO: Creating $steam_cmd_folder folder..."
mkdir -p "$steam_cmd_folder" || exit

echo "[>] INFO: Navigating to $steam_cmd_folder folder..."
cd "$steam_cmd_folder" || exit

echo "[>] INFO: Retrieving SteamCMD latest version..."
if wget -q "$steam_cmd_latest_version_url" -O "$steam_cmd_file"; then
  echo "[✓] OK: $steam_cmd_folder/$steam_cmd_file downloaded correctly."
else
    echo "[x] ERROR: we can't download $steam_cmd_file"
    exit 1
fi

if tar zxf "$steam_cmd_file"; then
  echo "[✓] OK: $steam_cmd_folder/$steam_cmd_file decompressed correctly."
  echo "[!] WARN: removing $steam_cmd_folder/$steam_cmd_file..."
  rm -f "$steam_cmd_file" || exit
else
    echo "[x] ERROR: we can't decompress $steam_cmd_folder/$steam_cmd_file"
    exit 1
fi

echo "[>] INFO: Returning to parent folder..."
cd .. || exit

echo "[✓] OK: $0 executed."