# ~~~~~~~~~~~~~~~~~~~~~~~~~~ Plain Old Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Personal Aliases
alias plex_scanner='/usr/lib/plexmediaserver/Plex\ Media\ Scanner'
alias TV='/media/TV/Media/TV'
alias Movies='/media/Movies/Media/Movies'
alias school='cd ~/Dropbox/calvin'

# Environment Variables
# Maybe at some point I should make this vim
export EDITOR="nano"

# Go directory
mkdir -p ~/go
mkdir -p ~/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ General Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias sudo='sudo '

# Startup
alias rc='vim ~/.bashrc'
alias rcs='vim ~/.bashrc && source ~/.bashrc'
alias rca='vim ~/.bash_aliases'
alias rcas='vim ~/.bash_aliases && source ~/.bash_aliases'
alias rcam='vim ~/.more_bash_aliases'
alias rcams='vim ~/.more_bash_aliases && source ~/.bash_aliases'

# List aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'
alias ldr='ls --color --group-directories-first'
alias ldl='ls --color -l --group-directories-first'

# Editting Aliases
alias s='source ~/.bashrc'
alias ea='vim ~/.bash_aliases'  # Edit aliases, that's why the a
alias eb='vim ~/.bashrc'
alias et='vim ~/.taskrc'

# Utility Aliasees

# Search your history
alias h="history|grep "


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Remote Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  

# SSH tools
alias offcampus='ssh tjd33@cs-ssh.calvin.edu'


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Tools ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# alias ack='ack-grep'

# From Karl, forgot to make these myself
# alias make='wrap_make'
# alias dts='wrap_dts'
# alias dtb='wrap_dtb'
# alias copy='wrap_copy'
# alias bt='wrap_bt'
# alias df='wrap_df'

alias agi='sudo apt-get install '
alias agu='sudo apt-get update && sudo apt-get upgrade'


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Localization ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

# Add go support
if [ -d /usr/local/go/bin ]; then
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=~/go
fi

if [ -e ~/.more_bash_aliases ]; then
    . ~/.more_bash_aliases
fi


# Various ones I am unlikely to use

# Find a file?
alias f="find . |grep "

# Search running processe
alias p="ps aux |grep "

# Make a python calculator
alias pycalc='python -ic "from __future__ import division; from math import *"'

# Directory traversal
alias github='mkdir -p ~/Github && cd ~/Github'

# Make your path shown in prompt either long or short
alias ps1_short="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '"
alias ps1_long="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '"

# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"

# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

# This will keep you sane when you're about to smash the keyboard again.
alias crap="fortune"


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Color Definitions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
black='\e[0;30m'
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
purple='\e[0;35m'
cyan='\e[0;36m'
light_grey='\e[0;37m'
dark_grey='\e[1;30m'
light_red='\e[1;31m'
light_green='\e[1;32m'
orange='\e[1;33m'
light_blue='\e[1;34m'
light_purple='\e[1;35m'
light_cyan='\e[1;36m'
white='\e[1;37m'
# Return color to normal formatting
NC='\e[0m'


