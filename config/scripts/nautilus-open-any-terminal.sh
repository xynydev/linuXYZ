#!/usr/bin/env bash

set -oue pipefail

echo "Installing nautilus-python & gettext"
rpm-ostree install nautilus-python gettext

echo "Installing nautilus-open-any-terminal"
cd /tmp/
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal
./tools/update-extension.sh install

echo "Setting default terminal to kitty"
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty