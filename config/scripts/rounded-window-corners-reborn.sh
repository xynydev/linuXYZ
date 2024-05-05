#!/usr/bin/env bash
set -oue pipefail

BUILD_DIR="./_build"
UUID="rounded-window-corners@fxgn"

cd /tmp
git clone https://github.com/flexagoon/rounded-window-corners
cd rounded-window-corners
just build

cp -r "$BUILD_DIR" "/usr/share/gnome-shell/extensions/$UUID"