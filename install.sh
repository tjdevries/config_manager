#!/bin/bash

printf "This script will install the updated scripts\n"

install_bash () {
	# Copy bashrc file
	cp ./bash/.bashrc ~/.bashrc -v
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
fi




