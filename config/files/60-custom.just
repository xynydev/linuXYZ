# add gnome extensions with gext, and some relocatable schema settings https://github.com/essembeh/gnome-extensions-cli
setup-gnome:
  pip install --upgrade gnome-extensions-cli
  # vitals
  gext install 1460

  # gsconnect
  gext install 1319

  # burn-my-windows
  gext install 4679

  # paperwm
  gext install 6099

  # rounded window corners
  # gext install 5237

  # panel date format
  gext install 1462
  dconf write /org/gnome/shell/extensions/panel-date-format/format "'%F %R'"

  # custom keybinds
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'kitty --detach --single-instance'"
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'terminal'"
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Alt>Return'"
