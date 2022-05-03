

if hash nvim 2>/dev/null; then
  export EDITOR=nvim

  # Use nvim as manpager `:h Man`
  export MANPAGER='nvim +Man!'
else
  export EDITOR=vim
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
