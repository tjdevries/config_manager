# Something for me to see where aliases get defined
# Use 256 colors
export TERM=xterm-256color
export LANG=en_US.UTF8

## Import locations
export ZSH=~/.config/oh-my-zsh/
export ZSH_CUSTOM=~/.config/zsh/
export CONFIG_HOME=$HOME/.config/
export ZPLUG_HOME=$CONFIG_HOME/zplug
export ZSH_HOME=$CONFIG_HOME/zplug
export ZSH_ENV_HOME=$HOME/
export NVIM_HOME=$CONFIG_HOME/nvim

## ZSH options
setopt functionargzero
setopt hist_ignore_space

## ZSH environment options
export DISABLE_LS_COLORS='true'

## Sources for important abilities
# source $ZSH/oh-my-zsh.sh
source "$ZPLUG_HOME/init.zsh"


alias_paths=( )
alias_with_path () {
    # BASE_PATH=`pwd -P`
    FILE_PATH="$0"

    # alias_paths+="$BASE_PATH/$FILE_PATH: Aliases $1"
    alias_paths+="File: $FILE_PATH ->    $1"
    \alias $1
}
# alias alias=alias_with_path

## Powerlevel configuration
# Not sure I have the right fonts for this yet...
# POWERLEVEL9K_MODE="awesome-patched"

DEFAULT_USER=$USER

POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

POWERLEVEL9K_SHOW_CHANGESE="true"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \Uf073 %d:%m:%y}"

max_commit_length=25
ellipsis_commit_length=$(($max_commit_length - 3))
get_commit_message(){
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    COMMIT_MESSAGE="$(git log -1 --pretty=%B)"
    if [ ${#COMMIT_MESSAGE} -gt $((ellipsis_commit_length + 1)) ]; then
      printf "[ %.${ellipsis_commit_length}s... ]" $COMMIT_MESSAGE 
    else
      printf "[ %.${max_commit_length}s ]" $COMMIT_MESSAGE
    fi
  fi
}

POWERLEVEL9K_CUSTOM_COMMIT_MESSAGE="get_commit_message"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_commit_message time)


if hash nvim 2>/dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

## Zsh Plugins
zplug 'zplug/zplug'

# zplug 'lib/history', from:oh-my-zsh, use:
# zplug 'lib/completion', from:oh-my-zsh
# zplug 'lib/directories', from:oh-my-zsh
# zplug 'lib/git', from:oh-my-zsh
# zplug 'lib/theme-and-appearance', from:oh-my-zsh

zplug 'zsh-users/zsh-autosuggestions', nice:-20
zplug 'zsh-users/zsh-completions', nice:19
# zplug 'zsh-users/zsh-syntax-highlighting', nice:19

zplug 'bhilburn/powerlevel9k', use:powerlevel9k.zsh-theme, nice:-19

zplug load


## My "Plugins"
sources=(
  'aliases'
  'git'
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/include/${s}.zsh
done


if zplug check zsh-users/zsh-autosuggestions; then
  bindkey '^ ' autosuggest-accept
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
fi

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=5
export LC_ALL=en_US.UTF-8

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
# {{{ Installers
install_emojify() {
  sudo sh -c "curl https://raw.githubusercontent.com/mrowa44/emojify/master/emojify -o /usr/local/bin/emojify && chmod +x /usr/local/bin/emojify"
}

install_zplug() {
  curl -sL zplug.sh/installer | zsh
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
export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.config/zsh/history

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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:/opt/Freescale/KDS_v3/toolchain/bin:$PATH"
eval "$(pyenv init -)"
