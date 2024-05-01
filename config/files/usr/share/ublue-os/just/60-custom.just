# add gnome extensions with gext, and some relocatable schema settings https://github.com/essembeh/gnome-extensions-cli
setup-gnome:
  pip install --upgrade gnome-extensions-cli
  # vitals
  gext install 1460

  # gsconnect
  gext install 1319

  ## arcmenu
  # gext install 3628

  # burn-my-windows
  gext install 4679

  # user themes
  gext install 19

  # space bar
  # gext install 5090

  # forge
  # gext install 4481

  # paperwm
  gext install 6099

  # rounded window corners
  gext install 5237

  # panel date format
  gext install 1462
  dconf write /org/gnome/shell/extensions/panel-date-format/format "'%F %R'"

  # custom keybinds
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'kitty --detach --single-instance'"
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'terminal'"
  dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Super>Return'"


workspace-shortcuts:
  #!/usr/bin/env bash
  for i in {1..9}; do
      gsettings set org.gnome.shell.keybindings switch-to-application-$i '[]'
      gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
      gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Shift><Super>$i']"
  done
