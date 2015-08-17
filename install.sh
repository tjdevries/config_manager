#!/bin/bash

printf "This script will install the updated scripts\n"

install_bash () {
	# Copy bashrc file
	cp ./bash/.bashrc ~/.bashrc -v
}

install_vim () {
    # Check to see if VIM is installed
    if [ ! $(which vim) ]
    then
        # Install VIM
        echo "VIM: Begin Installation"
        sudo apt-get install vim
        echo "VIM: Installed Succesfully"
        echo ""
    fi

    # Check to see if pathogen is installed
    if [ ! -d ~/.vim/autoload ]
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
    
    # Copy VIM file
    cp ./vim/.vimrc ~/.vimrc -v
}


if [ $1 == '-h' ]
then
	printf "This is the help command\n"
	printf "Command options: \n"
	echo -e '-a | --all \tInstall all the configuration tools'
	echo -e "-b | --bash\tInstall the bash tools only"
elif [ $1 == '-a' ]
then
	install_bash
    install_vim
fi




