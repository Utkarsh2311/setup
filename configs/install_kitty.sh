#!/bin/bash

#Function to install kitty
install_kitty(){
    ID=$(check_os)
    ID_OSTYPE="${ID}-${OSTYPE}"

    case "$ID_OSTYPE" in
        "mac-darwin"*)
            echo "Installing kitty on macOS..."
            brew install --cask kitty
            ;;
        "ubuntu-linux-gnu"|"debian-linux-gnu"|"ubuntu debian-linux-gnu")
            echo "Installing kitty on Ubuntu/Debian..."
            sudo apt install -y kitty
            ;;
        "fedora-linux-gnu")
            echo "Installing kitty on Fedora..."
            sudo dnf install -y kitty
            ;;
        "centos-linux-gnu"|"rhel-linux-gnu")
            echo "Installing kitty on CentOS/RHEL..."
            sudo yum install -y kitty
            ;;
        "arch-linux-gnu"|"manjaro-linux-gnu")
            echo "Installing kitty on Arch/Manjaro..."
            yay -Sy --noconfirm kitty
            ;;
        "suse-linux-gnu"|"opensuse-linux-gnu")
            echo "Installing kitty on openSUSE/SUSE..."
            sudo zypper install -y kitty
            ;;
        *)
            echo "Operating system not supported by this script. Detected: $ID_OSTYPE"
            exit 1
            ;;
    esac
       
    # Verify if kitty is installed
    if which kitty >/dev/null 2>&1; then
        echo "Kitty installed successfully!"
    else
        echo "Failed to install Kitty."
        echo "Run the script again by solving errors"
        exit 1
    fi
}
