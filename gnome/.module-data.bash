#!/bin/bash
module_install() {
    local mod_dir=$(realpath "$(dirname "$0")")
    find $mod_dir -type f -name '*.dconf' -exec sh -c "dconf load / < {}" \;
}
