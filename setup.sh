#!/bin/bash

#Function to show help menu
help(){
        echo "One for ALL setup script"
        echo -------------------  
		echo "      USAGE "  
		echo ------------------- 
        echo "Arguments:"
        echo " -a            Installs zsh,neovim,tmux and kitty"
        echo " -k            Installs kitty"
        echo " -z            Installs only zsh"
        echo " -n            Installs zsh + neovim"
        echo " -t            Installs only tmux"
}

# Function to detect the OS
function check_os {
    if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS detected
            OS='mac'
            
    elif [ -f /etc/os-release ]; then
            # Linux OS detected
            . /etc/os-release
            OS=$ID_LIKE
            fi
    echo "$OS"
}

#Function to install dependencies and print OS to the user
print_os(){
    if [[ "$OSTYPE" == "darwin"* ]]; then
           echo "Mac OS found SED LIFE"
    elif [ $(uname) == 'Linux' ]; then
           echo -e "Linux OS found! Grreeaaattt Choice............\n"
    fi
    echo -e "Initialising Script\n"
    echo "Installing dependencies"
    yay -Sy --noconfirm cowsay tar wget curl git &> /dev/null
    sudo apt install -y cowsay tar wget curl git &> /dev/null
    brew install cowsay tar wget curl git &> /dev/null
    sudo dnf install -y cowsay tar wget curl git &> /dev/null
    sudo yum install -y cowsay tar wget curl git &> /dev/null
    sudo zypper install -y cowsay tar wget curl git &> /dev/null
    cowsay -f dragon "SIT BACK AND RELAX NOW, SCRIPT WILL DO ALL THE WORK"
}

source configs/install_zsh.sh
source configs/install_neovim.sh
source configs/install_tmux.sh
source configs/install_kitty.sh

run(){
    if [ $# -eq 0 ]; then
        echo "[-] No arguments provided."
        help
        exit 1
    fi

    if [ $# -le 1 ]; then
        case "$1" in
            "-h")
                help
                ;;
            "-a")
                print_os
                check_zsh_installed
                check_nvim_installed
                check_tmux_installed
                install_kitty
                ;;
            "-k")
                print_os
                install_kitty
                ;;
            "-z")
                print_os
                check_zsh_installed
                ;;
            "-n")
                print_os
                check_zsh_installed
                check_nvim_installed
                ;;
            "-t")
                print_os
                check_tmux_installed
                ;;
            *)
                echo "[-] Invalid argument."
                help
                ;;
        esac
    else
        echo "[-] Wrong usage"
        echo "[-] Check help section for proper usage" 
        exit 1
    fi
}

run $@
