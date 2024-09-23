#!/bin/bash

#Function to check if zsh is installed or not
check_zsh_installed() {
    if which zsh >/dev/null 2>&1; then
        echo "Zsh is already installed."
        get_zsh_config
        sleep 1
        get_scripts
        sleep 1
    else
        echo "Zsh is not installed. Proceeding with installation..."
        install_zsh
        sleep 1
        get_zsh_config
        sleep 1        
        change_shell
        sleep 1
        get_scripts
    fi
}

check_homebrew_installed(){
if command -v brew >/dev/null 2>&1; then
            echo "Homebrew found, installing zsh..."
        else
            echo "Homebrew is not installed. Please install Homebrew first: https://brew.sh"
            exit 1
        fi
}

#Function to install zsh
install_zsh() {
    ID="$(check_os)"
    ID_OSTYPE="${ID}-${OSTYPE}"

    case "$ID_OSTYPE" in
        "mac-darwin"*)
            echo "Installing zsh on macOS..."
            check_homebrew_installed
            brew install zsh
            brew install fzf
            brew install zoxide
            ;;
        "ubuntu-linux-gnu"|"debian-linux-gnu")
            echo "Installing zsh on Ubuntu/Debian..."
            sudo apt update && sudo apt install -y zsh zoxide fzf
            ;;
        "kali-linux-gnu")
            echo "Installing zsh on Kali Linux..."
            sudo apt update && sudo apt install -y zsh zoxide fzf
            ;;
        "fedora-linux-gnu")
            echo "Installing zsh on Fedora..."
            sudo dnf install -y zsh zoxide fzf
            ;;
        "centos-linux-gnu"|"rhel-linux-gnu")
            echo "Installing zsh on CentOS/RHEL..."
            sudo yum install -y zsh zoxide fzf
            ;;
        "arch-linux-gnu"|"manjaro-linux-gnu")
            echo "Installing zsh on Arch/Manjaro..."
            yay -Sy --noconfirm zsh-completions zsh zoxide fzf
            ;;
        "suse-linux-gnu"|"opensuse-linux-gnu")
            echo "Installing zsh on openSUSE/SUSE..."
            sudo zypper install -y zsh zoxide fzf
            ;;
        *)
            echo "Operating system not supported by this script. Detected: $ID_OSTYPE"
            exit 1
            ;;
    esac
       
    # Verify if zsh is installed
    if which zsh >/dev/null 2>&1; then
        echo "Zsh installed successfully!"
    else
        echo "Failed to install zsh."
        echo "Run the script again by solving errors"
        exit 1
    fi
}

#Function to change the shell to zsh
change_shell(){
    current_shell=$(echo $SHELL)
    zsh_path=$(which zsh)

    if [[ "$current_shell" == "$zsh_path" ]]; then
        echo "Zsh is already the default shell."
    else
        echo "Changing the default shell to zsh..."
       chsh -s "$zsh_path"
   
    fi
}

#Function to get zsh config from github
get_zsh_config(){
    cd
    echo "Getting ZSH config from github"
    #zsh_url="https://github.com/Utkarsh2311/zsh.git"
    if [ -d zsh ]; then
    sudo rm -r zsh
    fi
    wget -r -nH http://13.229.122.51:8080/zsh 
    #git clone $zsh_url
    cd zsh
    cp .zshrc ..
    cp .zsh_aliases ..
    sudo rm -r ~/zsh
}

#Function to get Scripts folder
get_scripts(){
    cd
    echo "Getting scripts folder"
    #script_url="https://github.com/Utkarsh2311/scripts.git"
    if [ -d scripts ]; then
    sudo rm -r scripts
    fi
    wget -r -nH http://13.229.122.51:8080/scripts
    #git clone $script_url
}
