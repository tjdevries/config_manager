#!/bin/bash

START_DIR="$(pwd)"

install_bash () {
    # Install Dependencies

    if [ ! "$(which weather)" ]
    then
        if [ ! $no_sudo ]; then
            echo "Bash: Installing weather"
            sudo apt-get install weather-util -y
            echo "Bash: Installed weather"
        fi
    fi

    # If the git is installed, we...
    if [ "$(which git)" ]
    then
        if [[ -f '/usr/lib/git-core/git-sh-prompt' ]]
        then
            source /usr/lib/git-core/git-sh-prompt
        fi
    fi

    # Copy bashrc file
	cp ./bash/.bash_aliases     ~/ -v
    cp ./bash/.bash_functions   ~/ -v
    cp ./bash/.bash_logout      ~/ -v
    cp ./bash/.bashrc           ~/ -v
    cp ./bash/.bash_taskwarrior ~/ -v
    cp ./bash/.bash_welcome     ~/ -v
    cp ./bash/.taskrc           ~/ -v

    source ~/.bashrc
}


install_task () {
    if [[ ! $(which task) ]]
    then
        if [ ! $no_sudo ]; then
            echo "Bash: Installing Task"
            sudo apt-get install task -y
            echo "Bash: Installed Task"
            echo -e "yes\n" | task 
        fi
    fi
}


install_vim () {
    # Check to see if VIM is installed
    if [ ! "$(which vim)" ]
    then
        # Install VIM
        echo "VIM: Begin Installation"
        if [ ! $no_sudo ]; then
            sudo apt-get install vim
        fi
        echo "VIM: Installed Succesfully"
        echo ""
    fi

    # Check to see if pathogen is installed
    if [[ ! -d ~/.vim/autoload ]]
    then
        # Install Dependencies
        echo "Pathogen: Install Dependencies"
        if [ ! "$(which curl)" ]; then
            sudo apt-get install curl > /dev/null
        fi
        echo "Pathogen: Dependencies Installed"

        echo "Pathogen: Begin Installation"
        # Install Pathogen
        # Directions from https://github.com/tpope/vim-pathogen
        mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
        echo "Pathogen: Installed Successfully"
    fi
    
    # Install flake8 for VIM (Python linter)
    if [[ ! -d ~/.vim/bundle/vim-flake8 ]]; then
        git clone git://github.com/nvie/vim-flake8 ~/.vim/bundle/vim-flake8
        
        # Flake 8 Configuration
        #   Set the line width to be 140 instead of 80
        echo -e "[flake8]\nmax-line-length = 140" > ~/.config/flake8
    fi

    $START_DIR/vim/install_vim.sh

    # link VIM file
    ln -sf $START_DIR/vim/.vimrc ~/.vimrc -v
    ln -sf $START_DIR/vim/.vimrc ~/vim/.vimrc -v
}

install_git () {
    # Check to see if git is installed
    if [ ! "$(which git)" ]
    then
        # Install Git
        echo "Git: Begin Installation"
        sudo apt-get install git
        echo "Git: Installed Successfully"
        echo ""
    fi

    # Configure git to have my global gitconfig file
    cp ./git/.gitconfig ~/ -v
    
}

install_tips () {
    # Installs our custom tips into the config folder
    mkdir -p ~/.config/

    cp -Rv ./tips/ ~/.config/ 
}

printf "This script will install the updated scripts\n"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo "$DIR"

# Check if we have sudo access
if [ "$2" == '-n' ]; then
    no_sudo=1
fi

if [ "$1" == '-h' ]; then
	printf "This is the help command\n"
	printf "Command options: \n"
	echo -e "-a | --all \tInstall all the configuration tools"
	echo -e "-b | --bash\tInstall the bash tools only"
    echo
    echo -e "If a previous command has been issued, specify '-n' to signify"
    echo -e "\tthat there is no ${red}sudo${NC} access"
elif [ "$1" == '-a' ]; then
	install_bash
    install_task
    install_vim
    install_git
    install_tips
elif [ "$1" == '-b' ]; then
    install_bash
fi




