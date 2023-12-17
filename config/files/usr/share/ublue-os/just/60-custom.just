!include 100-bling.just

# Include some of your custom scripts here!

# https://github.com/essembeh/gnome-extensions-cli
setup-gext:
  pip install --upgrade gnome-extensions-cli
  # vitals
  gext install 1460
  # gsconnect
  gext install 1319
  # arcmenu
  gext install 3628
  # burn-my-windows
  gext install 4679
  # user themes
  gext install 19
  # space bar
  gext install 5090
  # forge
  gext install 4481
  # rounded window corners
  gext install 5237

workspace-shortcuts:
  #!/usr/bin/env bash
  for i in {1..9}; do
      gsettings set org.gnome.shell.keybindings switch-to-application-$i '[]'
      gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
      gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Shift><Super>$i']"
  done