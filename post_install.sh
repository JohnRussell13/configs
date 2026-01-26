#!/usr/bin/env bash
set -euo pipefail

USERNAME="alex"
HOSTNAME="archlinux"
TIMEZONE="Europe/Belgrade"
LOCALE="en_US.UTF-8"

echo "==> Setting timezone"
ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
hwclock --systohc

echo "==> Setting locale"
sed -i "s/^#\($LOCALE\)/\1/" /etc/locale.gen
locale-gen
echo "LANG=$LOCALE" >/etc/locale.conf

echo "==> Setting hostname"
echo "$HOSTNAME" >/etc/hostname

echo "==> Enabling services"
systemctl enable NetworkManager

echo "==> Installing packages"
./packages.sh

echo "==> Creating user: $USERNAME"
if ! id "$USERNAME" &>/dev/null; then
    useradd -m -G wheel "$USERNAME"
    passwd "$USERNAME"
fi

echo "==> Configuring sudo"
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "==> Done. Reboot when ready."
