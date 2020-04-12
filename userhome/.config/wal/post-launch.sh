#!/usr/bin/env bash
IMG="$(cat ~/.cache/wal/wal)"

# For awesomewm -- only to send refresh signal
if command -v awesome-client /dev/null 2>&1; then
  echo 'awesome.emit_signal("pywal::apply")' | awesome-client
fi

# For XFCE4
if command -v xfconf-query /dev/null 2>&1; then
  xfconf-query --channel xfce4-desktop --list | grep last-image | while read path; do
    xfconf-query --channel xfce4-desktop --property $path --set "$IMG"
  done
fi

# For GNOME
if command -v gsettings /dev/null 2>&1; then
  gsettings set org.gnome.desktop.background picture-uri "file://$IMG"
fi

if command -v qdbus /dev/null 2>&1; then
  # For KDE
  qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var a=desktops();
    for(i=0;i<a.length;i++) {
      b=a[i];
      b.wallpaperPlugin='org.kde.image';
      b.currentConfigGroup=Array('Wallpaper','org.kde.image','General');
      b.writeConfig('Image','$IMG');
    }
  "
fi
