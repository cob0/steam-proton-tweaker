#!/usr/bin/env bash

print_help() {
  echo "Usage: $0 [OPTIONS] <game_title>"
  echo ""
  echo "Options:"
  echo "  -h, --help                       Show this help message and exit."
  echo "  -l, --list-supported-games       List all supported game titles."
  echo ""
  echo "Arguments:"
  echo "  <game_title>      The name of the game to repair (must contain lowercase letters and may optionally include numbers and hyphens and match an existing directory)."
  echo ""
  echo "Examples:"
  echo "  $0 gothic"
  echo "  $0 -h"
  echo "  $0 --help"
  exit 0
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    print_help
fi

if [ "$#" -ne 1 ]; then
    echo "[x] ERROR: exactly one argument is required."
    exit 1
fi

game_title=$1

echo "[>] INFO: game title received: $game_title"
if [[ ! "$game_title" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
    echo "[x] ERROR: the game title must contain lowercase letters and may optionally include numbers and hyphens."
    exit 1
fi

game_title_fix_filename_path="./games/$game_title/$game_title.sh"

if [ ! -f "$game_title_fix_filename_path" ]; then
    echo "[x] ERROR: The game title $game_title is not supported"
    echo "Please check the list of supported games by running the tool with the '-l' or '--list-supported-games' option."
    exit 1
fi

if ! sh "$game_title_fix_filename_path"; then
    echo "[x] ERROR: $game_title_fix_filename_path execution failed."
    exit 1
fi