#!/usr/bin/env bash

set -oue pipefail

echo "Installing nautilus-python"
rpm-ostree install nautilus-python

echo "Installing nautilus-open-any-terminal"
cd /tmp/
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal
./tools/update-extension-system.sh install

echo "Setting default terminal to kitty"
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty