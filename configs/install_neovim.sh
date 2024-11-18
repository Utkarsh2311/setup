#!/bin/bash


#Function to install neovim
install_neovim(){
    ID="$(check_os)"
    ID_OSTYPE="${ID}-${OSTYPE}"

    case "$ID_OSTYPE" in
        "mac-darwin"*)
            echo "Installing neovim on macOS..."
            brew install neovim
            git clone https://github.com/Utkarsh2311/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
            ;;
        "ubuntu-linux-gnu"|"debian-linux-gnu"|"ubuntu debian-linux-gnu")
            echo "Installing neovim on Ubuntu/Debian..."
            git clone https://github.com/Utkarsh2311/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
            ;;
        "fedora-linux-gnu")
            echo "Installing neovim on Fedora..."
            sudo dnf install -y neovim python3-neovim
            git clone https://github.com/Utkarsh2311/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
            ;;
        "centos-linux-gnu"|"rhel-linux-gnu")
            echo "Installing neovim on CentOS/RHEL..."
            sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
            sudo yum install -y neovim python3-neovim
            git clone https://github.com/Utkarsh2311/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
            ;;
        "arch-linux-gnu"|"manjaro-linux-gnu")
            echo "Installing neovim on Arch/Manjaro..."
            yay -Sy --noconfirm neovim
            git clone https://github.com/Utkarsh2311/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
            ;;
        "suse-linux-gnu"|"opensuse-linux-gnu")
            echo "Installing neovim on openSUSE/SUSE..."
            sudo zypper in neovim
            sudo zypper in python-neovim python3-neovim
            git clone https://github.com/Utkarsh2311/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
            ;;
        *)
            echo "Operating system not supported by this script. Detected: $ID_OSTYPE"
            exit 1
            ;;
    esac
       
    # Verify if neovim is installed
    if which nvim >/dev/null 2>&1; then
        echo "Neovim installed successfully!"
    else
        echo "Failed to install Neovim."
        echo "Run the script again by solving errors"
        exit 1
    fi
}

#Function to check if neovim is installed or not
check_nvim_installed(){
     if [ -d ~/.config/nvim ]; then
        sudo rm -r ~/.config/nvim
        if which nvim >/dev/null 2>&1; then
            echo "Neovim Already Installed !"
            echo "Getting conf from github"
            git clone https://github.com/Utkarsh2311/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
        else
            install_neovim
        fi
    fi
}


