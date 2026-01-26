#!/usr/bin/env bash
set -euo pipefail

PKG_FILE=backup_packages

# Ensure paru exists
if ! command -v paru >/dev/null; then
    sudo pacman -S --needed --noconfirm base-devel git
    tmp=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$tmp/paru"
    (cd "$tmp/paru" && makepkg -si --noconfirm)
    rm -rf "$tmp"
fi

sudo pacman -Syu --noconfirm

# Read file into two arrays split by empty line
mapfile -t lines <"$PKG_FILE"

explicit=()
deps=()
target=explicit

for pkg in "${lines[@]}"; do
    [[ -z "$pkg" ]] && { target=deps; continue; }
    target+=("$pkg")
done

# Install
paru -S --needed --noconfirm "${explicit[@]}"
paru -S --needed --noconfirm --asdeps "${deps[@]}"

echo "All packages installed."
