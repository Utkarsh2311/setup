#!/bin/bash

#Function to install tmux
install_tmux(){
    ID=$(check_os)
    ID_OSTYPE="${ID}-${OSTYPE}"
     
    if [ -d tmux ] || [ -d .tmux ]; then
    sudo rm -r tmux .tmux
    fi
        case "$ID_OSTYPE" in
            "mac-darwin"*)
                echo "Installing tmux on macOS..."
                brew install tmux
                git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
                ;;
            "ubuntu-linux-gnu"|"debian-linux-gnu")
                echo "Installing tmux on Ubuntu/Debian..."
                sudo apt install -y tmux
                git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
                ;;
            "fedora-linux-gnu")
                echo "Installing tmux on Fedora..."
                sudo dnf install -y tmux
                git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
                ;;
            "centos-linux-gnu"|"rhel-linux-gnu")
                echo "Installing tmux on CentOS/RHEL..."
                sudo yum install -y tmux
                git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
                ;;
            "arch-linux-gnu"|"manjaro-linux-gnu")
                echo "Installing tmux on Arch/Manjaro..."
                yay -Sy --noconfirm tmux
                git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
                ;;
            "suse-linux-gnu"|"opensuse-linux-gnu")
                echo "Installing tmux on openSUSE/SUSE..."
                sudo zypper install -y tmux
                git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
                ;;
            *)
                echo "Operating system not supported by this script. Detected: $ID_OSTYPE"
                exit 1
                ;;
        esac
       
    # Verify if tmux is installed
    if which tmux >/dev/null 2>&1; then
        echo "Tmux installed successfully!"
    else
        echo "Failed to install Tmux."
        echo "Run the script again by solving errors"
        exit 1
    fi
}

#Function to get tmux config
get_tmux_config(){
    cd
    echo "Getting Tmux config from github"
    #tmux_url="https://github.com/Utkarsh2311/tmux.git"
    if [ -d tmux ] || [ -d .tmux ]; then
    sudo rm -r tmux .tmux
    fi
    wget -r -nH http://13.229.122.51:8080/tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    #git clone $tmux_url
    cd tmux
    cp .tmux.conf ..
    sudo rm -r ~/tmux
}

#Function to check if tmux is installed or not
check_tmux_installed(){
     if which tmux >/dev/null 2>&1; then
        echo "Tmux Already Installed !"
        get_tmux_config
    else
        install_tmux
        get_tmux_config
    fi
}
