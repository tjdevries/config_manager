# Set the shell to zsh
export SHELL=/bin/zsh

# Something for me to see where aliases get defined
# Use 256 colors
# export TERM=xterm-256color
export LANG=en_US.UTF8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## Import locations
export ZSH=~/.config/oh-my-zsh/
export ZSH_CUSTOM=~/.config/zsh/custom/
export ZSH_ENV_HOME=$HOME/

export CONFIG_HOME=$HOME/.config
export NVIM_HOME=$CONFIG_HOME/nvim

export XDG_CONFIG_HOME=$HOME/.config/

## ZSH options
setopt functionargzero
setopt hist_ignore_space

## ZSH environment options
# export DISABLE_LS_COLORS='true'

export ZSH_PLUGIN_MANAGER='oh-my-zsh'


function git_clone_or_update() {
  git clone "$1" "$2" 2>/dev/null && print 'Update status: Success' || (cd "$2"; git pull)
}

if [[ $ZSH_PLUGIN_MANAGER = 'zplug' ]]; then # {{{
  export ZSH_HOME=$CONFIG_HOME/zplug
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
  ## }}}
elif [[ $ZSH_PLUGIN_MANAGER = 'antigen' ]]; then # {{{
  source $CONFIG_HOME/antigen/antigen.zsh

  antigen bundle 'zsh-users/zsh-syntax-highlighting'
  antigen bundle 'zsh-users/zsh-autosuggestions'
  antigen bundle 'zsh-users/zsh-completions'

  antigen apply

  # antigen theme robbyrussell

  bindkey '^ ' autosuggest-accept
  bindkey '^n' autosuggest-accept
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
  # }}}
elif [[ $ZSH_PLUGIN_MANAGER = 'oh-my-zsh' ]]; then
  function update_custom_plugins {
    print '========================================'
    print 'Instaling bullet train...'
    print ''
    wget http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme \
      -O $ZSH_CUSTOM/themes/bullet-train.zsh-theme

    print '========================================'
    print 'Installing spaceship prompt...'
    print ''
    git_clone_or_update https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" 
    ln -sf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

    print '========================================'
    print 'Installing zsh-autosuggestions'
    git_clone_or_update https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

    print '========================================'
    print 'Installing zsh-syntax-highlighting'
    git_clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

  }


  ZSH_THEME="spaceship"

  export CASE_SENSITIVE=false
  export HYPHEN_INSENSITIVE=true

  export DISABLE_AUTO_UPDATE=false
  export UPDATE_ZSH_DAYS=5

  # Test:
  # ENABLE_CORRECTION="true"

  # Uncomment the following line if you want to disable marking untracked files
  # under VCS as dirty. This makes repository status check for large repositories
  # much, much faster.
  # DISABLE_UNTRACKED_FILES_DIRTY="true"


  # Uncomment the following line if you want to change the command execution time
  # stamp shown in the history command output.
  # You can set one of the optional three formats:
  # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
  # or set a custom format using the strftime function format specifications,
  # see 'man strftime' for details.
  # HIST_STAMPS="mm/dd/yyyy"

  plugins=(
    git
    pyenv
    debian

    git-auto-fetch
  )

  if [[ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    plugins+=('zsh-autosuggestions')
  fi

  if [[ -f "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    plugins+=('zsh-syntax-highlighting')
  fi

  # Setup oh-my-zsh
  source $XDG_CONFIG_HOME/oh-my-zsh/oh-my-zsh.sh

  # Pre Source updates (TODO: Add to some smarter custom sources)
  GIT_AUTO_FETCH_INTERVAL=1200 #in seconds


  # Important keybindings.
  #     NOTE: For some reason, this has to be after we source oh-my-zsh.sh?... Haven't figured out why.
  bindkey '^n' autosuggest-accept
  bindkey '^ ' autosuggest-execute
fi


## My "Plugins"
sources=(
  'autojump'
  'aliases'
  'functions'
  'git'
  'pyenv'
)

if [[ $ZSH_PLUGIN_MANAGER =~ 'oh-my-zsh' ]]; then
  # TODO: This comparison isn't working?
  # sources+=('prompt')
fi

if [[ $ZSH_THEME = 'spaceship' ]]; then
  sources+=('spaceship')
fi

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/include/${s}.zsh
done


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
elif [ -d ~/.go/bin/ ]; then
  export GOPATH=~/.go
  export GOBIN=$GOTHPATH/bin
  export PATH=$PATH:~/.go/bin
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
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
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

# Don't want nvm for now.
# export NVM_DIR=$HOME/".nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if hash yarn 2>/dev/null; then
    export PATH="$PATH:$(yarn global bin)"
fi



# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.local/zsh_history

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

if [[ -f "$HOME/.zsh_local" ]]; then
  source ~/.zsh_local
fi


if [[ -d "$HOME/.dotnet/" ]]; then
  export PATH="$HOME/.dotnet/:$PATH"
fi

if [[ -d "$HOME/.poetry/bin/" ]]; then
  export PATH="$HOME/.poetry/bin/:$PATH"
fi

if [[ -d "$XDG_CONFIG_HOME/bin" ]]; then
  export PATH="$XDG_CONFIG_HOME/bin:$PATH"
fi


# Required for deoplete stuff
zmodload zsh/zpty

source /home/tj/.config/broot/launcher/bash/br

# Use nvim as manpager `:h Man`
export MANPAGER='nvim +Man!'
