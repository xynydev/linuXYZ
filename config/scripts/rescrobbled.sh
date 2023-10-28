#!/usr/bin/env bash
set -oue pipefail

echo "Downloading latest rescrobbled binary"
curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/InputUsername/rescrobbled/releases/latest \
    | jq .assets[0].browser_download_url \
    | xargs wget -o /usr/bin/rescrobbled
chmod +x /usr/bin/rescrobbled

echo "Downloading rescrobbled systemd unit"
curl https://raw.githubusercontent.com/InputUsername/rescrobbled/master/rescrobbled.service > /usr/lib/systemd/user/rescrobbled.service

echo "Enabling rescrobbled systemd unit"
systemctl enable --global -f rescrobbled.service