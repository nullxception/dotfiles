#!/bin/sh
POLKIT_LIB=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
case "${DESKTOP_SESSION-}" in
  gnome*) # Done by gnome-settings-daemon
  ;;
  *)
    exec $POLKIT_LIB &
  ;;
esac
