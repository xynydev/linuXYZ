#!/usr/bin/env bash
set -oue pipefail

rpm -q kernel-headers
uname -r

cd /tmp
git clone https://github.com/lwfinger/rtw88
cd rtw88

KERNELRELEASE=$(uname -r)

make
make install
make install_fw