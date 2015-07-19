# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

##########################
# Not sure what these do #
##########################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make VIM the global editor
export VISUAL=vim
export EDITOR="$VISUAL"


# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (assumes that anything connected that supports x-term can support color...)
case "$TERM" in
    xterm*) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# If git isn't installed yet... these may fail
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

set_bash_prompt()
{
    if [ "$color_prompt" = yes ]; then
        RESET='\[\e[0m\]'
        C11='\[\e[1;32m\]'
        C13='\[\e[1;34m\]'
        export GIT_PS1_SHOWCOLORHINTS=1
        PS1="${debian_chroot:+($debian_chroot)}$C11\u@\h$RESET $C13\w$RESET$(__git_ps1 ' (%s)')$RESET\$ "
    else
        PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 ':(%s)')\$ "
    fi
}

# This tells bash to reinterpret PS1 after every command, which we need because
# __git_ps1 could be outputting color codes
PROMPT_COMMAND=set_bash_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -F --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# --------------------------- References to other files---------------------------
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# General bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# General bash functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Task warrior commands to make using it more efficient
if [ -f ~/.bash_taskwarrior ]; then
    . ~/.bash_taskwarrior
fi

# A fun welcome screen for when you open a terminal :)
if [ -f ~/.bash_welcome ]; then
    . ~/.bash_welcome
fi


# -------------------------------- From Server -------------------------------


export PS1='$(task +in +PENDING count) '$PS1






