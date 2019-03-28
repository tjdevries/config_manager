export PROMPT_DEBUG=true
export PROMPT_GIT=true

export IS_A_GIT_DIR=0

# {{{ Prompt functions
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
  if [[ $IS_A_GIT_DIR -eq 1 ]]; then
    print "[$(git log --pretty=format:'%h' -n 1)]"
  fi
}
# }}}
# {{{ get_commit_message
max_commit_length=35
ellipsis_commit_length=$(($max_commit_length - 3))
get_commit_message(){
  if [[ $IS_A_GIT_DIR -eq 1 ]]; then
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
# }}}

# setopt prompt_subst
# precmd_prompt() {
#   set_git_dir
#   PROMPT='$(my_current_directory) $(get_git_branch)> '
# }

# precmd_functions+=(precmd_prompt)

function get_pyenv_version {
  if [ $PYENV_VERSION ]; then
    print '('$PYENV_VERSION')'
  fi
}

setopt prompt_subst
function precmd() {
  set_git_dir
}

PROMPT='$(get_pyenv_version) %B%t%b %n:%0~  $(get_commit_hash) $(get_commit_message)
 >> '

