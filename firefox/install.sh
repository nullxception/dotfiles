CURR=$(realpath $(dirname $0))
TARGET=$HOME/.mozilla/firefox
INIFILE=$TARGET/profiles.ini

mkdir -p $TARGET
if [[ ! -f "$INIFILE" ]]; then
    echo "no firefox profile detected on $TARGET, creating a new ones"
    printf '%s\n'\
      "[General]"\
      "StartWithLastProfile=1"\
      "[Profile0]"\
      "Name=default"\
      "IsRelative=1"\
      "Path=00000001.default"\
      "Default=1" > $INIFILE
fi

awk '/\[/{prefix=$0; next} $1{print prefix $0}' "$INIFILE" | grep Path | sed -e 's/.*Path=//g' | while read profile; do
    echo "Installing files to $TARGET/$profile"
    cp -af $CURR/files/. $TARGET/$profile
done