#!/usr/bin/env bash

set -oue pipefail

echo "Installing nautilus-python"
rpm-ostree install nautilus-python

echo "Installing nautilus-open-any-terminal"
pip install nautilus-open-any-terminal

echo "Setting default terminal to kitty"
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty