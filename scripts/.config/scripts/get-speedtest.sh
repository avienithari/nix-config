#!/usr/bin/env bash


declare distro

choose_distro() {
    echo "Select your base distribution:"
    echo "[1] - Debian/Ubuntu"
    echo "[2] - OSX"

    read -rp "Enter the number of your base distribution: " distro_choice

    case "$distro_choice" in
        1) distro="debian";;
        2) distro="osx";;
        *) echo "Invalid choice. Exiting."; exit 1 ;;
    esac
}

apt_install() {
    sudo apt-get install curl
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
    sudo apt-get install speedtest
}

brew_install() {
    brew tap teamookla/speedtest
    brew update
    brew install speedtest --force
}

choose_distro

case $distro in
    "debian" | "ubuntu")
        apt_install
        ;;
    "osx")
        brew_install
        ;;
esac
