#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/bin"
HOME_DIR="${HOME-}"

if [[ -z "$HOME_DIR" || "$HOME_DIR" != /* || "$HOME_DIR" == "/" ]]; then
    echo "HOME must be a non-root absolute path" >&2
    exit 1
fi

DEST_DIR="$HOME_DIR/bin"

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Source directory does not exist: $SOURCE_DIR" >&2
    exit 1
fi

mkdir -p "$DEST_DIR"

found=0
for source_file in "$SOURCE_DIR"/*; do
    [[ -f "$source_file" ]] || continue

    install -m 755 "$source_file" "$DEST_DIR/$(basename "$source_file")"
    found=1
done

if [[ "$found" -eq 0 ]]; then
    echo "No files found in $SOURCE_DIR" >&2
    exit 1
fi

echo "Installed utilities to $DEST_DIR"