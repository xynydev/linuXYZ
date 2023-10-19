!include /usr/share/ublue-os/just/100-bling.just

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