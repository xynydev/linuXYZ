#!/usr/bin/env bash
set -oue pipefail

mkdir -p /boot/EFI/refind
cd /boot/EFI/refind
mkdir themes | true
cd themes
git clone https://github.com/catppuccin/refind.git catppuccin
cd ..
echo "include themes/catppuccin/mocha.conf" > refind.conf 