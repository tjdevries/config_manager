# Get the async plugin up and running
source $ZPLUG_HOME/repos/mafredri/zsh-async/async.zsh
async_init

# Start some workers...
async_start_worker left_worker -n
async_start_worker right_worker -n
# And register them to a callback
async_register_callback left_worker left_prompt_completed_callback
async_register_callback right_worker right_prompt_completed_callback

setopt prompt_subst
setopt promptsubst

MY_PROMPT=true

# {{{ Prompt options
# Debug mode?
PROMPT_DEBUG=true
PROMPT_GIT=false

# For how long we want the time and date to be
date_start=1
date_end=19
# }}}
# {{{ Prompt configuration
# {{{ Prompt functions
# {{{ Async functions
LEFT_LINE='orig'
RIGHT_LINE='orig'
left_prompt_completed_callback() {
  LEFT_LINE=$3

  prompt_print_debug $@
  COMPLETED=$(( COMPLETED + 1 ))
}

right_prompt_completed_callback() {
  RIGHT_LINE=$3

  prompt_print_debug $@
  COMPLETED=$(( COMPLETED + 1 ))
}

prompt_build_left_line() {
  LEFT_LINE='%F{yellow}$(my_date)%f'
  LEFT_LINE=$LEFT_LINE': '
  LEFT_LINE=$LEFT_LINE'%F{39}'
  LEFT_LINE=$LEFT_LINE'$(my_current_directory)'
  LEFT_LINE=$LEFT_LINE'%f '

  if [ $PROMPT_GIT = true ]; then
    LEFT_LINE=$LEFT_LINE'%F{gray}'"$(get_commit_hash)"'%f'
    LEFT_LINE=$LEFT_LINE'%F{007}'"$(get_git_branch)"'%f'
  fi

  print $LEFT_LINE
}

prompt_build_right_line() {
  if [ $PROMPT_GIT = true ]; then
    RIGHT_LINE='%F{red}$(get_commit_message)%f'
  else
    # Nice message ;)
    RIGHT_LINE='fixed'
  fi

  print $RIGHT_LINE
}
# }}}
# {{{ Debuggin and logging
prompt_print_debug() {
  if [ $PROMPT_DEBUG = true ]; then
    print $@
  fi
}
# }}}
# {{{ get_string_length
prompt_pure_string_length() {
  local str=$1
  # perform expansion on str and check length
  echo $(( ${#${(S%%)str//(\%([KF1]|)\{*\}|\%[Bbkf])}} ))
}
# }}}
# {{{ set_git_dir
set_git_dir() {
  if [ $PROMPT_GIT = true ]; then
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
      export IS_A_GIT_DIR=1
    else
      export IS_A_GIT_DIR=0
    fi
  else
    export IS_A_GIT_DIR=0
  fi
}
# }}}
# {{{ get_commit_hash
get_commit_hash(){
  if [ $IS_A_GIT_DIR -eq 1 ]; then
    echo "[$(git log --pretty=format:'%h' -n 1)]"
  fi
}
# }}}
# {{{ get_commit_message
max_commit_length=35
ellipsis_commit_length=$(($max_commit_length - 3))
get_commit_message(){
  if [ $IS_A_GIT_DIR -eq 1 ]; then
    COMMIT_MESSAGE="$(git log -1 --pretty=%B | head -n1)"
  fi

  if [ $IS_A_GIT_DIR -eq 1 ]; then
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
    printf "[ $RVM_PROMPT%$VENV_NAME_WIDTH.${VENV_NAME_WIDTH}s %3.3s ]" $pyenv_name $pyenv_version
  fi
}
# }}}
# {{{ get_git_branch
get_git_branch() {
  # Maybe we should use this instead?
  # git rev-parse --abbrev-ref HEAD

  # Maybe we should make a function for this so that it's easier.
  if [ $IS_A_GIT_DIR -eq 1 ]; then
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
# {{{ my_current_directory
export __old_pwd=''
my_current_directory() {
  # Quick result
  # TODO: Make this work correctly.
  # __current_pwd="$(pwd)"
  # if [[ $__current_pwd == $__old_pwd ]]; then
  #   print $__mcd_result
  #   return
  # else
  #   print "did not save time"
  # fi

  # TODO: Make this know more about virtualenvs?
  if [ $IS_A_GIT_DIR -eq 1 ]; then
    __git_dir="$(git rev-parse --show-toplevel)"
    __this_dir="$(pwd)"

    if [ $__git_dir = $__this_dir ]; then
      # print "$__git_dir"
      __mcd_result="\ue0a0/${__git_dir:t}"
    else
      # print "${__git_dir#$__this_dir}"
      __git_dir="${__git_dir:h}"
      __mcd_result="\ue0a0${__this_dir#$__git_dir}"
    fi
  else
    __mcd_result="%~"
  fi

  print $__mcd_result
}
# }}}

if [ $MY_PROMPT = true ]; then
  # {{{ Prompt building
  # Set the timeout to one second, could be larger if we wanted.
  # TMOUT=1
  MY_PID=$$

  get_virtual_env='%F{gray}$(virtual_env_info)%f'

  precmd_prompt() {
    # Set the variable for if we are in a git directory or not
    set_git_dir

    prompt_print_debug "working on it..."

    COMPLETED=0
    JOBS_TO_COMPLETE=2

    async_job left_worker prompt_build_left_line
    async_job right_worker prompt_build_right_line

    prompt_print_debug "spawned jobs..."

    while (( COMPLETED < JOBS_TO_COMPLETE )); do
      prompt_print_debug "Waiting... -> " $COMPLETED '/' $JOBS_TO_COMPLETE
      sleep 0.1
    done

    prompt_print_debug "done waiting..."

    integer left_length=$(prompt_pure_string_length $LEFT_LINE)
    integer right_length=$(prompt_pure_string_length $RIGHT_LINE)

    prompt_print_debug "subtractions..."

    DISTANCE=$(( $COLUMNS - 1 - $left_length - $right_length ))

    prompt_print_debug "distance..."

    # Build the prompt from our components
    PROMPT='
'$LEFT_LINE${(l:$DISTANCE:: :)}${RIGHT_LINE}'
'$get_virtual_env' > '

    # End of prompt builder
  }

  # This used to be a bunch of functions, but now we just added this thing only.
  # precmd_functions+=(precmd_prompt)

  # Old recursive updater used: TRAPALRM(). Look up if you want to look at it
  # }}}
else  # {{{10
  zplug 'bhilburn/powerlevel9k', use:powerlevel9k.zsh-theme, nice:-19
fi

# {{{10 Powerlevel configuration
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
# }}}
# }}}
