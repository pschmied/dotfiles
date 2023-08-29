#!/bin/bash

# Set keyboard layout to dvorak
loadkeys dvorak

# Update system clock
timedatectl set-ntp true

# Partition the drive
nvme_dev=$(ls /dev | grep nvme0n1)
parted -s /dev/$nvme_dev mklabel gpt
parted -s /dev/$nvme_dev mkpart ESP fat32 1MiB 513MiB
parted -s /dev/$nvme_dev mkpart primary ext4 513MiB 100%

# Format the partitions
mkfs.fat -F32 /dev/${nvme_dev}p1
mkfs.ext4 /dev/${nvme_dev}p2

# Mount the partitions
mount /dev/${nvme_dev}p2 /mnt
mkdir /mnt/boot
mount /dev/${nvme_dev}p1 /mnt/boot

# Install base packages
pacstrap /mnt base linux linux-firmware sudo emacs sway steam kitty julia r python rust firefox signal-desktop

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the new system
arch-chroot /mnt /bin/bash <<EOF

# Timezone setup for Seattle
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc

# Localization setup
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Network setup
echo "maui" > /etc/hostname
echo "127.0.1.1	maui.localdomain	maui" >> /etc/hosts

# Create user
useradd -m peter
echo "peter:test123" | chpasswd
echo "peter ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
passwd -e peter

# Install and set up systemd-boot
bootctl --path=/boot install

# Create boot entry
cat > /boot/loader/entries/arch.conf <<EOL
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=/dev/${nvme_dev}p2 rw
EOL

# Optionally set default loader settings (optional)
echo "default arch" > /boot/loader/loader.conf

EOF

# Reboot
echo "Installation complete. Please reboot the system."
