#!/usr/bin/env bash
IMG="$(cat ~/.cache/wal/wal)"

# For awesomewm -- only to send refresh signal
if command -v awesome-client 2>&1 /dev/null; then
    echo 'awesome.emit_signal("pywal::apply")' | awesome-client
fi

# For XFCE4
if command -v xfconf-query 2>&1 /dev/null; then
  xfconf-query --channel xfce4-desktop --list | grep last-image | while read path; do
      xfconf-query --channel xfce4-desktop --property $path --set "$IMG"
  done
fi

# For GNOME
gsettings set org.gnome.desktop.background picture-uri "file://$IMG"

