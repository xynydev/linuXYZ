#!/usr/bin/env bash
set -oue pipefail

cd /tmp/kernel-rpms
dnf install -y kernel-devel*

cd /tmp
git clone https://github.com/lwfinger/rtw88
cd rtw88

dnf install -y dkms

dkms install $PWD
make install_fw