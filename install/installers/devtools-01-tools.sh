#!/bin/bash
APP_NAME="Build Tools"
APP_COMMAND=("make" "rg")

install_tools() {
    install_and_show_versions build-essential ripgrep
}