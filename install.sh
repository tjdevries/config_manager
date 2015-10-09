#!/bin/bash

printf "This script will install the updated scripts\n"

install_bash () {
    # Install Dependencies
    if [[ ! $(which task) ]]
    then
        echo "Bash: Installing Task"
        sudo apt-get install task -y
        echo "Bash: Installed Task"
        echo -e "yes\n" | task 
    fi

    if [ ! "$(which weather)" ]
    then
        echo "Bash: Installing weather"
        sudo apt-get install weather-util -y
        echo "Bash: Installed weather"
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
	cp ./bash/.bash_aliases  ~/ -v
    cp ./bash/.bash_functions  ~/ -v
    cp ./bash/.bash_logout   ~/ -v
    cp ./bash/.bashrc   ~/ -v
    cp ./bash/.bash_taskwarrior  ~/ -v 
    cp ./bash/.bash_welcome   ~/ -v
    cp ./bash/.taskrc ~/ -v

    source ~/.bashrc
}

install_vim () {
    # Check to see if VIM is installed
    if [ ! "$(which vim)" ]
    then
        # Install VIM
        echo "VIM: Begin Installation"
        sudo apt-get install vim
        echo "VIM: Installed Succesfully"
        echo ""
    fi

    # Check to see if pathogen is installed
    if [[ ! -d ~/.vim/autoload ]]
    then
        # Install Dependencies
        echo "Pathogen: Install Dependencies"
        sudo apt-get install curl > /dev/null
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

    ./vim/install_vim.sh

    # Copy VIM file
    cp ./vim/.vimrc ~/.vimrc -v
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

    # Configure git to have my name and email
    
}

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo "$DIR"


if [ "$1" == '-h' ]; then
	printf "This is the help command\n"
	printf "Command options: \n"
	echo -e '-a | --all \tInstall all the configuration tools'
	echo -e "-b | --bash\tInstall the bash tools only"
elif [ "$1" == '-a' ]; then
	install_bash
    install_vim
    install_git
elif [ "$1" == '-b' ]; then
    install_bash
fi




