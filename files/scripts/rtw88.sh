#!/usr/bin/env bash
set -oue pipefail

cd /tmp

git clone https://github.com/lwfinger/rtw88

cd rtw88

make

sudo make install

sudo make install_fw

sudo modprobe rtw_8814au
