#!/bin/bash
module_target="$HOME/.local/bin"

module_postinstall() {
    chmod -v +x $module_target/*
}
