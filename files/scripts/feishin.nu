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

cp --recursive /usr/share/feishin/resources/assets/icons /usr/share/icons/feishin
