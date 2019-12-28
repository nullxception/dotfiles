#!/usr/bin/env bash
CURR=$(realpath $(dirname $0))
TARGET=$HOME/.local/bin

echo "installing files to $(realpath $TARGET)"
cp -avf $CURR/files/. $TARGET/