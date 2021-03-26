#!/bin/bash
module_target="/etc"

module_postinstall() {
    sudo sysctl -p /etc/sysctl.d/*
}
