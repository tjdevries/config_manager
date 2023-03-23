export _TJ_PROFILE=0

if [[ $_TJ_PROFILE -eq 1 ]]; then
  zmodload zsh/datetime
  PS4='+$EPOCHREALTIME %N:%i> '

  logfile=$(mktemp zsh_profile.XXXXXXXX)
  echo "Logging to $logfile"
  exec 3>&2 2>$logfile

  setopt XTRACE
fi

# Set the shell to zsh
export SHELL=/bin/zsh

# Something for me to see where aliases get defined
# Use 256 colors
# export TERM=xterm-256color
export LANG=en_US.UTF8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## Import locations
export ZSH_CUSTOM=~/.config/zsh/custom/
export ZSH_ENV_HOME=$HOME/

export XDG_CONFIG_HOME=$HOME/.config/

## ZSH options
setopt functionargzero
setopt hist_ignore_space

## ZSH environment options


## ZSH plugins
fpath=($XDG_CONFIG_HOME/zsh/submods/gcloud-zsh-completion/src/ $fpath)

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit
function git_clone_or_update() {
  git clone "$1" "$2" 2>/dev/null && print 'Update status: Success' || (cd "$2"; git pull)
}

source $XDG_CONFIG_HOME/antigen/antigen.zsh

antigen bundle 'zsh-users/zsh-syntax-highlighting'
antigen bundle 'zsh-users/zsh-autosuggestions'
# antigen bundle 'zsh-users/zsh-completions'

antigen bundle 'agkozak/zsh-z'

# antigen theme spaceship-prompt/spaceship-prompt
# antigen theme robbyrussell

antigen apply

eval "$(starship init zsh)"

bindkey '^ ' autosuggest-accept
bindkey '^n' autosuggest-accept

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

## My "Plugins"
sources=(
  'autojump'
  'aliases'
  'functions'
  'git'
  'pyenv'
)

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
# }}}
# {{{1 Language specific configuration
# {{{2 Go
if [ -d /usr/local/go/bin/ ]; then
  export GOPATH=~/go
  export GOBIN="$GOPATH/bin"
  export PATH="/usr/local/go/bin:$GOBIN:$PATH"
elif [ -d ~/.go/bin/ ]; then
  export GOPATH="$HOME/.gopath"
  export GOROOT="$HOME/.go"
  export GOBIN="$GOPATH/bin"
  export PATH="$GOPATH/bin:$PATH"
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

  export GEM_HOME="$HOME/gems"
  export PATH="$HOME/gems/bin:$PATH"

  # Rvm configuration
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
else
  export HAS_RVM=false
fi
# }}}
# {{{ Rust
export PATH="$HOME/.cargo/bin:$PATH"
# }}}
# }}}
#

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

if [[ -f "$XDG_CONFIG_HOME/broot/launcher/bash/br" ]]; then
  source /home/tj/.config/broot/launcher/bash/br
fi

export GCLOUD_HOME="$HOME/Downloads/google-cloud-sdk"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$GCLOUD_HOME/path.zsh.inc" ]; then
    . "$GCLOUD_HOME/path.zsh.inc";
fi

# The next line enables shell command completion for gcloud.
if [ -f "$GCLOUD_HOME/completion.zsh.inc" ]; then
    . "$GCLOUD_HOME/completion.zsh.inc";
fi

export PATH="$HOME/.local/bin/:$PATH"

if [ -f "$HOME/.asdf/asdf.sh" ]; then
  # . $HOME/.asdf/asdf.sh
  # . $HOME/.asdf/completions/asdf.bash

  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi


export PATH="$HOME/.poetry/bin:$PATH"

if [[ $_TJ_PROFILE -eq 1 ]]; then
  unsetopt XTRACE
  exec 2>&3 3>&-
fi


setopt PROMPT_SUBST

# if hash luarocks 2>/dev/null; then
#     export LUA_PATH=$(luarocks path --lr-path)
#     export LUA_CPATH=$(luarocks path --lr-cpath)
# fi

# function lua_statusline() {
#   luajit /home/tjdevries/.config/zsh/prompt.lua $?
# }
# export PS1='$(luajit /home/tjdevries/.config/zsh/prompt.lua)'
# export PS1='$(lua_statusline)'
# export PS1='$(pwd) > '

function zshexit() {
  # TODO: Clean up any associated things that are left open from lua land
}

export NVM_COMPLETION=true
export NVM_DIR=$HOME/".nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if hash yarn 2>/dev/null; then
  export PATH="$PATH:$(yarn global bin)"
fi

export DENO_INSTALL="/home/tjdevries/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

alias luamake=/home/tjdevries/.cache/nvim/nlua/sumneko_lua/lua-language-server/3rd/luamake/luamake

[[ ! -r /Users/tjdevries@sourcegraph.com/.opam/opam-init/init.zsh ]] || source /Users/tjdevries@sourcegraph.com/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

