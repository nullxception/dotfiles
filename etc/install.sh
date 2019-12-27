#!/usr/bin/env bash
CURR=$(realpath $(dirname $0))
TARGET=/etc

echo "installing files to $(realpath $TARGET)"
sudo cp -avf $CURR/files/. $TARGET/