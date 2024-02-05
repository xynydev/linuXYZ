#!/usr/bin/env bash

set -oue pipefail

echo "Installing nautilus-python & gettext & make"
rpm-ostree install nautilus-python gettext make

echo "Installing nautilus-open-any-terminal"
cd /tmp/
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal
make
make install schema 

echo "Setting default terminal to kitty"
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
