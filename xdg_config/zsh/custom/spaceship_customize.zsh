# Prefix
if [ $IS_SSH ]; then
  # Prompt replacement symbols
  export SPACESHIP_PROMPT_DEFAULT_PREFIX='/ '
  export SPACESHIP_CHAR_SYMBOL='-> '

  # Git replacement symbols
  export SPACESHIP_GIT_SYMBOL='git:'

  export SPACESHIP_GIT_STATUS_UNTRACKED='?'
  export SPACESHIP_GIT_STATUS_AHEAD='^'
  export SPACESHIP_GIT_STATUS_BEHIND='v'
  export SPACESHIP_GIT_STATUS_DIVERGED='<diverged>'
else
  export SPACESHIP_PROMPT_DEFAULT_PREFIX='❯ '
fi

# Time
export SPACESHIP_TIME_SHOW=true

# Pyenv
SPACESHIP_PYENV_SYMBOL="pyenv:"

SPACESHIP_PROMPT_ORDER=(
  user
  dir
  git
  aws
  pyenv
  exec_time
  line_sep
  vi_mode
  exit_code
  char
)


# Hacks to get RPOMPT on top line :)
function spaceship_rprompt_prefix() {
  echo -n '%{'$'\e[1A''%}'
}

function spaceship_rprompt_suffix() {
  echo -n '%{'$'\e[1B''%}'
}

# RPROMPT
SPACESHIP_RPROMPT_ORDER=(
  rprompt_prefix
  time
  rprompt_suffix
)

