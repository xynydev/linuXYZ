# some relocatable schema settings
setup-gnome:
  dconf write /org/gnome/shell/extensions/panel-date-format/format "'A %B %A (%F) at %R'"

  # custom keybinds
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'foot'"
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'terminal'"
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Alt>Return'"
