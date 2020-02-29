#!/usr/bin/env bash
#
# sync.sh
#
#
CURR=$(realpath $(dirname $0))
TARGET=$HOME/.local/bin

find $CURR/files/ -type f | while read rfile; do
  file=$(sed "s|"$CURR"/files/||g" <<<$rfile)
  if ! cmp "$TARGET/$file" "$CURR/files/$file" >/dev/null 2>&1; then
    echo "file: $file is different."
    echo "syncing $file"
    cp "$TARGET/$file" "$CURR/files/$file"
  fi
done
