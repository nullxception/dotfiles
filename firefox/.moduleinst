#!/bin/bash
module_install() {
  ff_dir=$HOME/.mozilla/firefox

  if [[ ! -f $ff_dir/profiles.ini ]]; then
    echo "no firefox profile detected, open firefox first before restoring tweaks"
    exit 1
  fi

  awk '/\[/{prefix=$0; next} $1{print prefix $0}' $ff_dir/profiles.ini | grep Path | sed -e 's/.*Path=//g' | while read profile; do
    if [[ -f $ff_dir/$profile/prefs.js ]]; then
      echo ":: Install user.js to $profile"
      cp -f $dotfiles/$mod/user.js $ff_dir/$profile
      mkdir -p $ff_dir/$profile/chrome
      echo ":: Install user css to $profile"
      cp -f $dotfiles/$mod/*.css $ff_dir/$profile/chrome/
    fi
  done
}
