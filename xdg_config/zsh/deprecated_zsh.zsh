if [[ $ZSH_PLUGIN_MANAGER = 'zplug' ]]; then # {{{
  export ZSH_HOME=$XDG_CONFIG_HOME/zplug
  export ZPLUG_HOME=$XDG_CONFIG_HOME/zplug

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
fi

if [[ $ZSH_PLUGIN_MANAGER = 'oh-my-zsh' ]]; then
  export ZSH=~/.config/oh-my-zsh/

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

    print '========================================'
    print 'Installing zsh-nvm'
    git_clone_or_update https://github.com/lukechilds/zsh-nvm "$ZSH_CUSTOM/plugins/zsh-nvm"
  }


  # ZSH_THEME="spaceship"

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

  if [[ -f "$ZSH_CUSTOM/plugins/zsh-nvm/README.md" ]]; then
    plugins+=('zsh-nvm')
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
#
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

