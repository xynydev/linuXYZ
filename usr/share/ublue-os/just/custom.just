!include /usr/share/ublue-os/just/bling.just

# install all flatpaks defined in recipe.yml
setup-flatpaks:
  #!/usr/bin/env bash
  echo 'Installing flatpaks from the ublue recipe ...'
  flatpaks=$(yq -- '.firstboot.flatpaks[]' "/usr/share/ublue-os/recipe.yml")
  for pkg in $flatpaks; do \
      echo "Installing: ${pkg}" && \
      flatpak install --user --noninteractive flathub $pkg; \
  done

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

# Include some of your custom scripts here! 