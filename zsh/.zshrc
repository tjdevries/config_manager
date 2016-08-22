# Something for me to see where aliases get defined
# Use 256 colors
export TERM=xterm-256color

set functionargzero

alias_paths=( )
alias_with_path () {
    # BASE_PATH=`pwd -P`
    FILE_PATH="$0"

    # alias_paths+="$BASE_PATH/$FILE_PATH: Aliases $1"
    alias_paths+="File: $FILE_PATH ->    $1"
    \alias $1
}

# alias alias=alias_with_path

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

export DISABLE_LS_COLORS='true'

if hash nvim 2>/dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# {{{ Plugin Configuration
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(python battery)
# }}}

sources=(
  'aliases'
  'git'
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/include/${s}.zsh
done


# {{{ Changes on default configuration
# Path to your oh-my-zsh installation.
export ZSH=~/.config/oh-my-zsh/
export ZSH_CUSTOM=$ZSH/custom
# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=5
export LC_ALL=en_US.UTF-8

# }}}

# {{{1 Functions
# {{{2 Extract Stuff
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
# }}}
# {{{2 Cute clock
# clock - A bash clock that can run in your terminal window.
clock ()
{
while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}
# }}}
# }}}

# {{{1 Language specific configuration

# {{{2 Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [ -d /usr/local/go/bin ]; then
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=~/go
fi
# }}}

# }}}

# {{{ Default configuration options
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:/opt/Freescale/KDS_v3/toolchain/bin:$PATH"
eval "$(pyenv init -)"
