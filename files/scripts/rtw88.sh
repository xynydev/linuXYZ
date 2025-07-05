#!/usr/bin/env bash
set -oue pipefail

rpm -q kernel
uname -r

cd /tmp
git clone https://github.com/lwfinger/rtw88
cd rtw88

KERNELRELEASE=$(rpm -q kernel | sed -e s/^kernel-//)

echo "kernel: $KERNELRELEASE"

sed -i "/^KVER ?= /s/.*/KVER := $KERNELRELEASE/" Makefile

make
make install
make install_fw