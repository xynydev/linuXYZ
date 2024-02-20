FROM ghcr.io/ublue-os/silverblue-nvidia:latest

LABEL org.opencontainers.image.title="linuxyz"
LABEL org.opencontainers.image.description="My personal uBlue image. Make your own! https://ublue.it/making-your-own/"
LABEL io.artifacthub.package.readme-url=https://raw.githubusercontent.com/ublue-os/startingpoint/main/README.md
LABEL io.artifacthub.package.logo-url=https://avatars.githubusercontent.com/u/120078124?s=200&v=4

ARG RECIPE=./config/recipe.yml
ARG IMAGE_REGISTRY=localhost
COPY cosign.pub /usr/share/ublue-os/cosign.pub

# Copy the bling from ublue-os/bling into tmp, to be installed later by the bling module
# Feel free to remove these lines if you want to speed up image builds and don't want any bling
COPY --from=ghcr.io/ublue-os/bling:latest /rpms /tmp/bling/rpms
COPY --from=ghcr.io/ublue-os/bling:latest /files /tmp/bling/files
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq
COPY --from=gcr.io/projectsigstore/cosign /ko-app/cosign /usr/bin/cosign

COPY --from=ghcr.io/blue-build/cli:latest-installer /out/bluebuild /usr/bin/bluebuild

COPY config /tmp/config/

# Copy modules
# The default modules are inside ublue-os/bling
COPY --from=ghcr.io/ublue-os/bling:latest /modules /tmp/modules/
# Custom modules overwrite defaults
COPY modules /tmp/modules/

RUN printf "#!/usr/bin/env bash\n\nget_yaml_array() { \n  readarray \"\$1\" < <(echo \"\$3\" | yq -I=0 \"\$2\")\n} \n\nexport -f get_yaml_array\nexport OS_VERSION=\$(grep -Po '(?<=VERSION_ID=)\d+' /usr/lib/os-release)" >> /tmp/exports.sh && chmod +x /tmp/exports.sh

ARG CONFIG_DIRECTORY="/tmp/config"
ARG IMAGE_NAME="linuxyz"
ARG BASE_IMAGE="ghcr.io/ublue-os/silverblue-nvidia"
COPY ./config/files/usr /usr
RUN chmod +x /tmp/modules/rpm-ostree/rpm-ostree.sh && source /tmp/exports.sh && /tmp/modules/rpm-ostree/rpm-ostree.sh '{"type":"rpm-ostree","repos":["https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-%OS_VERSION%/atim-starship-fedora-%OS_VERSION%.repo","https://copr.fedorainfracloud.org/coprs/peterwu/rendezvous/repo/fedora-%OS_VERSION%/peterwu-rendezvous-fedora-%OS_VERSION%.repo","https://pkgs.tailscale.com/stable/fedora/tailscale.repo"],"install":["python","rsync","syncthing","kitty","starship","zsh","fish","rEFInd","qemu","libvirt","virt-manager","virt-install","tailscale","pcmanfm","thunar","nemo","gnome-shell-extension-blur-my-shell","python3-pip","bibata-cursor-themes"],"remove":["firefox","firefox-langpacks"]}'
RUN chmod +x /tmp/modules/default-flatpaks/default-flatpaks.sh && source /tmp/exports.sh && /tmp/modules/default-flatpaks/default-flatpaks.sh '{"type":"default-flatpaks","user":{"install":["com.brave.Browser","com.github.GradienceTeam.Gradience.Devel","com.github.tchx84.Flatseal","hu.kramo.Cartridges","io.itch.itch","com.usebottles.bottles","org.prismlauncher.PrismLauncher","fr.handbrake.ghb","io.mpv.Mpv","com.logseq.Logseq","md.obsidian.Obsidian","com.obsproject.Studio","com.google.AndroidStudio","com.jetbrains.IntelliJ-IDEA-Community","io.github.dweymouth.supersonic","io.gitlab.librewolf-community","nl.hjdskes.gcolor3","org.audacityteam.Audacity","org.blender.Blender","org.kde.kdenlive","org.shotcut.Shotcut","org.kde.krita","org.fedoraproject.MediaWriter","org.freedesktop.Piper","org.gnome.Loupe","org.gnome.World.PikaBackup","org.gtk.Gtk3theme.Catppuccin-red","org.gtk.Gtk3theme.adw-gtk3","org.gtk.Gtk3theme.adw-gtk3-dark","org.musicbrainz.Picard","org.speedcrunch.SpeedCrunch"]}}'
RUN chmod +x /tmp/modules/script/script.sh && source /tmp/exports.sh && /tmp/modules/script/script.sh '{"type":"script","scripts":["nautilus-open-any-terminal.sh","rescrobbled.sh","signing.sh"]}'
RUN chmod +x /tmp/modules/systemd/systemd.sh && source /tmp/exports.sh && /tmp/modules/systemd/systemd.sh '{"type":"systemd","system":{"enabled":["mount-on-boot.service"]}}'
RUN chmod +x /tmp/modules/fonts/fonts.sh && source /tmp/exports.sh && /tmp/modules/fonts/fonts.sh '{"type":"fonts","fonts":{"nerd-fonts":["FiraCode","Hack","SourceCodePro","Terminus","JetBrainsMono","NerdFontsSymbolsOnly","SpaceMono"],"google-fonts":["Roboto","Open Sans","Work Sans","Outfit","Space Grotesk"]}}'
RUN chmod +x /tmp/modules/gschema-overrides/gschema-overrides.sh && source /tmp/exports.sh && /tmp/modules/gschema-overrides/gschema-overrides.sh '{"type":"gschema-overrides","include":["zz1-linuxyz.gschema.override"]}'


RUN rm -rf /tmp/* /var/* && ostree container commit