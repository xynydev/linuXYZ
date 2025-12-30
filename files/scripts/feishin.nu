#!/usr/libexec/bluebuild/nu/nu

let url = http get https://api.github.com/repos/jeffvli/feishin/releases | get 0 | get assets | where name =~ "-linux-x64.tar.xz" | get browser_download_url | get 0

let file = http get $url | save "/tmp/feishin.tar.xz"

mkdir /usr/share/feishin
tar xvf "/tmp/feishin.tar.xz" --strip-components=1 -C "/usr/share/feishin"

chmod +x /usr/share/feishin/feishin

ln -s /usr/share/feishin/feishin /usr/bin/feishin

"[Desktop Entry]
Name=Feishin
GenericName=Music player
Exec=/usr/bin/feishin --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto
TryExec=/usr/bin/feishin
Terminal=false
Type=Application
Icon=org.jeffvli.feishin
StartupWMClass=feishin
SingleMainWindow=true
Categories=AudioVideo;Audio;Player;Music;
Keywords=Navidrome;Jellyfin;Subsonic;OpenSubsonic
Comment=A player for your self-hosted music server" | save "/usr/share/applications/feishin.desktop"

cp /usr/share/feishin/resources/assets/icons/512x512.png /usr/share/icons/hicolor/512x512/apps/org.jeffvli.feishin.png

cp /usr/share/feishin/resources/assets/icons/256x256.png /usr/share/icons/hicolor/256x256/apps/org.jeffvli.feishin.png

cp /usr/share/feishin/resources/assets/icons/128x128.png /usr/share/icons/hicolor/128x128/apps/org.jeffvli.feishin.png

cp /usr/share/feishin/resources/assets/icons/64x64.png /usr/share/icons/hicolor/64x64/apps/org.jeffvli.feishin.png

cp /usr/share/feishin/resources/assets/icons/32x32.png /usr/share/icons/hicolor/32x32/apps/org.jeffvli.feishin.png

sudo gtk-update-icon-cache -f -t /usr/share/icons
