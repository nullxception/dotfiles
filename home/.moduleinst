#!/bin/bash
module_target="$HOME"

module_postinstall() {
    # Configure KDE Fonts
    if command -v kwriteconfig5 > /dev/null 2>&1; then
        kwriteconfig5 --group General --key XftAntialias true
        kwriteconfig5 --group General --key XftHintStyle hintslight
        kwriteconfig5 --group General --key XftSubPixel rgb
    fi
    # Configure GNOME Fonts
    if command -v dconf > /dev/null 2>&1; then
        dconf write /org/gnome/settings-daemon/plugins/xsettings/antialiasing "'rgba'"
        dconf write /org/gnome/settings-daemon/plugins/xsettings/hinting "'slight'"
    fi
}
