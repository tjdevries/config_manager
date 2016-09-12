alias s='source ~/.config/zsh/.zshrc'
# {{{1 Edit Aliases
alias ez='$EDITOR ~/.config/zsh/.zshrc'
alias gn='cd ~/Git/neovim/src/nvim/'
alias en='$EDITOR ~/Git/config_manager/vim/.nvimrc'
# }}}

# {{{1 General Aliases
alias ls='ls -F --color=auto --group-directories-first --sort=version'
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'
alias ldr='ls --color --group-directories-first'
alias ldl='ls --color -l --group-directories-first'

alias h="history|grep "

alias agi='sudo apt-get install '
alias agu='sudo apt-get update && sudo apt-get upgrade'
# {{{3 Disk Aliases
# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"

# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
# }}}
# }}}

# {{{1 SSH Aliases
alias offcampus='ssh tjd33@cs-ssh.calvin.edu'
# }}}
# {{{ Tree aliases
alias pt='tree -I "__pycache__|*.pyc" --dirsfirst -v'
# }}}
