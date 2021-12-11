#!/bin/bash
module_target="$HOME/.config"

module_postinstall() {
    # enable the service
    systemctl enable --user ssh-agent.service
}
