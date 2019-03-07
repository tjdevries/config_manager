# Set the shell to zsh
export SHELL=/bin/zsh


# Something for me to see where aliases get defined
# Use 256 colors
# export TERM=xterm-256color
export LANG=en_US.UTF8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## Import locations
export ZSH=~/.config/oh-my-zsh/
export ZSH_CUSTOM=~/.config/zsh/
export ZSH_HOME=$CONFIG_HOME/zplug
export ZSH_ENV_HOME=$HOME/

export CONFIG_HOME=$HOME/.config

export NVIM_HOME=$CONFIG_HOME/nvim

## ZSH options
setopt functionargzero
setopt hist_ignore_space

## ZSH environment options
export DISABLE_LS_COLORS='true'

export ZSH_PLUGIN_MANAGER='antigen'

if [[ $ZSH_PLUGIN_MANAGER = 'zplug' ]]; then
  ## Zplug {{{
  export ZPLUG_HOME=$CONFIG_HOME/zplug

  source "$ZPLUG_HOME/init.zsh"

  ## Zsh Plugins
  zplug 'zplug/zplug', at:expand_glob

  # zplug "lib/history", from:oh-my-zsh,
  zplug "lib/completion", from:oh-my-zsh, defer:2
  zplug "lib/directories", from:oh-my-zsh, defer:2
  zplug "lib/git", from:oh-my-zsh, defer:2
  # zplug "lib/theme-and-appearance", from:oh-my-zsh, nice:0

  zplug 'zsh-users/zsh-autosuggestions', defer:3
  zplug 'zsh-users/zsh-completions', defer:3
  # zplug 'zsh-users/zsh-syntax-highlighting', nice:19

  # Nice gitignore helper
  zplug 'voronkovich/gitignore.plugin.zsh'

  # Various hints
  zplug 'djui/alias-tips', use:"alias-tips.plugin.zsh"
  zplug 'joepvd/zsh-hints'

  # Async helper
  # zplug 'mafredri/zsh-async', defer:2
  # zplug 'intelfx/pure', defer:3

  zplug load

  if zplug check zsh-users/zsh-autosuggestions; then
    bindkey '^ ' autosuggest-accept
    bindkey '^n' autosuggest-accept
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
  fi
elif [[ $ZSH_PLUGIN_MANAGER = 'antigen' ]]; then
  source $CONFIG_HOME/antigen/antigen.zsh

  antigen bundle 'zsh-users/zsh-syntax-highlighting'
  antigen bundle 'zsh-users/zsh-autosuggestions'
  antigen bundle 'zsh-users/zsh-completions'

  antigen apply

  # antigen theme robbyrussell

  bindkey '^ ' autosuggest-accept
  bindkey '^n' autosuggest-accept
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

fi


## My "Plugins"
sources=(
  'autojump'
  'aliases'
  'functions'
  'git'
  'prompt'
  'pyenv'
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/include/${s}.zsh
done


# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=5
export LC_ALL=en_US.UTF-8


# {{{1 Functions
# {{{2 Alias paths
alias_paths=( )
alias_with_path () {
    # BASE_PATH=`pwd -P`
    FILE_PATH="$0"

    # alias_paths+="$BASE_PATH/$FILE_PATH: Aliases $1"
    alias_paths+="File: $FILE_PATH ->    $1"
    \alias $1
}
# alias alias=alias_with_path
# }}}
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
if [ -d /usr/local/go/bin/ ]; then
    export GOPATH=~/go
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:/usr/local/go/bin:$GOBIN
fi
# }}}
# {{{2 Haskell
export HASKELLPATH="$HOME/.cabal/bin"
export PATH=$PATH:$HASKELLPATH
# }}}
# {{{2 Ruby configuration
if [ -f ~/.rvm/scripts/rvm ]; then
  export HAS_RVM=true
  source ~/.rvm/scripts/rvm
else
  export HAS_RVM=false
fi
# }}}
# {{{ Rust
export PATH="$HOME/.cargo/bin:$PATH"
# }}}
# {{{ NPM configuratoin
export PATH=~/.npm-global/bin:$PATH
# }}}
# }}}
#
if hash nvim 2>/dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi


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

# Rvm configuration
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}
