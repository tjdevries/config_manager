
alias pa='pyenv activate'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# TODO: Figure out how to do this only if this virtualenv exists.
# pyenv activate general
