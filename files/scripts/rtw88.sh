#!/usr/bin/env bash
set -oue pipefail

cd /tmp
git clone https://github.com/lwfinger/rtw88
cd rtw88

make
make install
make install_fw