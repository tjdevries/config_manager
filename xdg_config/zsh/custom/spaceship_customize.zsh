# Prefix
export SPACESHIP_PROMPT_DEFAULT_PREFIX='❯ '

# Time
export SPACESHIP_TIME_SHOW=true

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

