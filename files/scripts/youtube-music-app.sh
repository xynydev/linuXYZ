#!/usr/bin/env bash
set -oue pipefail

cd /tmp

ASSETS_URL=$(curl https://api.github.com/repos/th-ch/youtube-music/releases/latest | jq '.assets_url' --raw-output)

LATEST_LINUX_YML_RELASE_URL=$(curl "$ASSETS_URL" | jq '.[0].url' --raw-output)
LATEST_LINUX_YML_DOWNLOAD_URL=$(curl "$LATEST_LINUX_YML_RELASE_URL" | jq '.browser_download_url' --raw-output)
wget "$LATEST_LINUX_YML_DOWNLOAD_URL"

RPM_FILENAME=$(yq '.files[2].url' latest-linux.yml)
VERSION_TAG="v$(yq '.version' latest-linux.yml)"
RPM_DOWNLOAD_URL="https://github.com/th-ch/youtube-music/releases/download/$VERSION_TAG/$RPM_FILENAME"

rpm-ostree install libuuid "$RPM_DOWNLOAD_URL"