#!/usr/bin/env bash
CURR=$(realpath $(dirname $0))
TARGET=$HOME

echo "installing files to $(realpath $TARGET)"
cp -avf $CURR/files/. $TARGET/
