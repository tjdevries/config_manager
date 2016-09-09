# Something for me to see where aliases get defined
# Use 256 colors
export TERM=xterm-256color
export LANG=en_US.UTF8
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

## Import locations
export ZSH=~/.config/oh-my-zsh/
export ZSH_CUSTOM=~/.config/zsh/
export CONFIG_HOME=$HOME/.config
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

if [ -f ~/.rvm/scripts/rvm ]; then
  export HAS_RVM=true
  source ~/.rvm/scripts/rvm
else
  export HAS_RVM=false
fi


alias_paths=( )
alias_with_path () {
    # BASE_PATH=`pwd -P`
    FILE_PATH="$0"

    # alias_paths+="$BASE_PATH/$FILE_PATH: Aliases $1"
    alias_paths+="File: $FILE_PATH ->    $1"
    \alias $1
}
# alias alias=alias_with_path


DEFAULT_USER=$USER
MY_PROMPT=true
MY_ASYNC_PROMPT=true

date_start=1
date_end=19
# {{{ Prompt configuration
# {{{ Prompt functions
# {{{ get_commit_message
max_commit_length=50
ellipsis_commit_length=$(($max_commit_length - 3))
get_commit_message(){
  # Trying to make sure it doesn't keep doing stuff over and over here,
  # but it's not working
  # if [ $MY_CMD = $HISTCMD ]; then
  #   echo "WOWOW"
  #   export MY_CMD=$(($MY_CMD + 1))
  # else
  #   echo "Changed!"
  # fi
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    COMMIT_MESSAGE="$(git log -1 --pretty=%B | head -n1)"
    if [ ${#COMMIT_MESSAGE} -gt $((ellipsis_commit_length + 1)) ]; then
      printf "[ %${ellipsis_commit_length}.${ellipsis_commit_length}s... ]" $COMMIT_MESSAGE 
    else
      printf "[ %${max_commit_length}.${max_commit_length}s ]" $COMMIT_MESSAGE
    fi
  fi
}
# }}}
# {{{ virtual_env_info
virtual_env_info() {
  # TODO: Get working with rvm
  # if [ $HAS_RVM = true ]; then
  #   RVM_PROMPT=$(~/.rvm/bin/rvm-prompt)
  # else
  #   RVM_PROMT=
  # fi
  # VENV_NAME_WIDTH=$(($date_end - $date_start - $VENV_VERSION_WIDTH - ${#RVM_PROMPT}))

  VENV_VERSION_WIDTH=3
  VENV_NAME_WIDTH=$(($date_end - $date_start - $VENV_VERSION_WIDTH))
  VENV_WIDTH=$((1 + $VENV_NAME_WIDTH + $VENV_VERSION_WIDTH))
  if [ -z "$VIRTUAL_ENV" ]; then
    printf "[ %$VENV_WIDTH.${VENV_WIDTH}s ]" "No pyenv used"
  else
    pyenv_version=$(echo $VIRTUAL_ENV | grep -o '[0-9]\.[0-9]\.[0-9]')
    pyenv_name=$(basename $VIRTUAL_ENV)

    # print "[ %8.8s ]" $pyenv_version $pyenv_name
    printf "[ $RVM_PROMPT %$VENV_NAME_WIDTH.${VENV_NAME_WIDTH}s %3.3s ]" $pyenv_name $pyenv_version
  fi
}
# }}}
# {{{ get_git_branch
get_git_branch() {
  # Maybe we should use this instead?
  # git rev-parse --abbrev-ref HEAD

  # Maybe we should make a function for this so that it's easier.
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    RESULT=$(git branch | grep "*" | cut -c3-)
    printf $RESULT
  fi
}
# }}}
# {{{ my_date
my_date() {
  printf "[ $(date | cut -c$date_start-$date_end) ]"
}
# }}}
# }}}

if [ $MY_PROMPT = true ]; then
  # {{{ Prompt building
  setopt prompt_subst
  setopt promptsubst

  if [ $MY_ASYNC_PROMPT = true ]; then
    # Set the timeout to one second, could be larger if we wanted.
    # TMOUT=1
    MY_PID=$$

    get_virtual_env='%F{gray}$(virtual_env_info)%f'

    precmd_prompt() {
      export MY_CMD=$HISTCMD
      export RUN_ONCE=false

      # We need to have a no format one, so it's easy to get the true length
      # This needs to be kept up to date with the true left line
      LEFT_LINE_NO_FORMAT="$(my_date): $(get_git_branch) %~"
      LEFT_LINE='%F{yellow}$(my_date)%f: %F{007}$(get_git_branch)%f %F{blue}%~%f'

      # We need to have a no format one, so it's easy to get the true length
      # This needs to be kept up to date with the true right line
      RIGHT_LINE_NO_FORMAT="$(get_commit_message)"
      RIGHT_LINE='%F{red}$(get_commit_message)%f'

      DISTANCE=$(($COLUMNS - 1 - ${#${(%%)LEFT_LINE_NO_FORMAT}} - ${#${(%%)RIGHT_LINE_NO_FORMAT}}))

      # Build the prompt from our components
      PROMPT='
'$LEFT_LINE${(l:$DISTANCE:: :)}${RIGHT_LINE}'
'$get_virtual_env' > '
    }
    precmd_functions+=(precmd_prompt)

    # RPROMPT='$(get_commit_message)'

    TRAPALRM() {
      if [ "$WIDGET" != "complete-word" ]; then
        # Trying to not make it reset if it isn't the main shell currently.
        # if [ $MY_PID = $$ ]; then
        #   zle reset-prompt
        # fi
        zle reset-prompt
      fi
    }
  else
    precmd_prompt () {
      empty_line=${(l:$COLUMNS:: :)}
      line_1_left="First line"
      line_1_right="Right side"
      line_1_center_length=$(($COLUMNS-${#line_1_left}))
      # "%{$fg[magenta]%}%n%{$reset_color%} in %~:"
      # "> "

    PROMPT='$empty_line
    $line_1_left${(l:$line_1_center_length::.:)line_1_right}
    > '
    }
    precmd_functions+=(precmd_prompt)
    PROMPT="
    %{$fg[magenta]%}%n%{$reset_color%} in %~:
    > "
    RPROMPT="$(get_commit_message)"
  fi
  # }}}
else
  zplug 'bhilburn/powerlevel9k', use:powerlevel9k.zsh-theme, nice:-19
fi
# }}}


if hash nvim 2>/dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

## Zsh Plugins
# zplug 'zplug/zplug', at:v2.1.0

# zplug "lib/history", from:oh-my-zsh, nice:0
zplug "lib/completion", from:oh-my-zsh, nice:0
zplug "lib/directories", from:oh-my-zsh, nice:0
zplug "lib/git", from:oh-my-zsh, nice:0
# zplug "lib/theme-and-appearance", from:oh-my-zsh, nice:0

zplug 'zsh-users/zsh-autosuggestions', nice:-20
zplug 'zsh-users/zsh-completions', nice:19
# zplug 'zsh-users/zsh-syntax-highlighting', nice:19


zplug load


if zplug check bhilburn/powerlevel9k; then
  ## Powerlevel configuration
  # Not sure I have the right fonts for this yet...
  # POWERLEVEL9K_MODE="awesome-patched"
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  POWERLEVEL9K_SHORTEN_DELIMITER=""
  POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

  POWERLEVEL9K_SHOW_CHANGESE="true"

  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
  POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "
  POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \Uf073 %m-%d-%y}"

  POWERLEVEL9K_CUSTOM_COMMIT_MESSAGE="get_commit_message"
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_commit_message time)
fi

if zplug check zsh-users/zsh-autosuggestions; then
  bindkey '^ ' autosuggest-accept
  bindkey '^n' autosuggest-accept
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
fi

## My "Plugins"
sources=(
  'aliases'
  'functions'
  'git'
  'autojump'
)

for s in "${sources[@]}"; do
  source $HOME/.config/zsh/include/${s}.zsh
done


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

# Rvm configuration
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
