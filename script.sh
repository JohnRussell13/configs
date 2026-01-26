#!/usr/bin/env bash

set -euo pipefail

PKG_FILE="packages.txt"
TEMP_DIR="/tmp/paru"

# -------------------------
# Helper functions
# -------------------------

install_base_paru() {
    # Install base-devel and git (required to build AUR packages)
    echo "Installing base-devel and git..."
    sudo pacman -S --needed --noconfirm base-devel git

    # Bootstrap paru
    echo "Bootstrapping paru..."
    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    cd /
    rm -rf "$TEMP_DIR"
}

# -------------------------
# Check package file
# -------------------------
if [[ ! -f "$PKG_FILE" ]]; then
    echo "Package file not found: $PKG_FILE"
    exit 1
fi

# -------------------------
# Update system
# -------------------------
echo "Updating system..."
sudo pacman -Syu --noconfirm

# -------------------------
# Ensure paru is installed
# -------------------------
if ! command -v paru &>/dev/null; then
    install_base_paru
fi

# -------------------------
# Install packages
# -------------------------
while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    # Trim whitespace
    pkg="${pkg#"${pkg%%[![:space:]]*}"}"
    pkg="${pkg%"${pkg##*[![:space:]]}"}"

    # Skip comments and empty lines
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue

    # Try pacman first
    if pacman -Si "$pkg" &>/dev/null; then
        echo "Installing $pkg (pacman)"
        sudo pacman -S --needed --noconfirm "$pkg"
    else
        echo "Installing $pkg (AUR)"
        paru -S --needed --noconfirm "$pkg"
    fi
done < "$PKG_FILE"

echo "All packages installed."
