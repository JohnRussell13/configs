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

echo "==> Setting root password"
passwd

echo "==> Installing must-haves"
pacman -S sudo grub efibootmgr networkmanager

echo "==> Enabling services"
systemctl enable NetworkManager

echo "==> Creating user: $USERNAME"
if ! id "$USERNAME" &>/dev/null; then
    useradd -m -g users -G uucp,input,wheel "$USERNAME"
    passwd "$USERNAME"
fi

echo "==> Configuring sudo"
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

echo "==> Installing GRUB (UEFI)"
read -rp "EFI partition (e.g. /dev/sda1 or /dev/nvme0n1p1): " EFI_PART
if [[ ! -b "$EFI_PART" ]]; then
  echo "ERROR: Not a block device: $EFI_PART"
  exit 1
fi
mkdir -p /boot/efi
mount "$EFI_PART" /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
umount /boot/efi

echo "==> Done. Reboot when ready."
