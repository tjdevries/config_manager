
# # Get the async plugin up and running
# source $ZPLUG_HOME/repos/mafredri/zsh-async/async.zsh
# async_init

# # Start some workers...
# async_start_worker left_worker -n
# async_start_worker right_worker -n
# # And register them to a callback
# async_register_callback left_worker left_prompt_completed_callback
# async_register_callback right_worker right_prompt_completed_callback

# setopt prompt_subst
# setopt promptsubst

# MY_PROMPT=true

# # {{{ Prompt options
# # Debug mode?

# # For how long we want the time and date to be
# date_start=1
# date_end=19
# # }}}
# # {{{ Prompt configuration
# if [ $MY_PROMPT = true ]; then
#   # {{{ Prompt building
#   # Set the timeout to one second, could be larger if we wanted.
#   # TMOUT=1
#   MY_PID=$$

#   get_virtual_env='%F{gray}$(virtual_env_info)%f'

#   precmd_prompt() {
#     # Set the variable for if we are in a git directory or not
#     set_git_dir

#     prompt_print_debug "working on it..."

#     COMPLETED=0
#     JOBS_TO_COMPLETE=2

#     async_job left_worker prompt_build_left_line
#     async_job right_worker prompt_build_right_line

#     prompt_print_debug "spawned jobs..."

#     while (( COMPLETED < JOBS_TO_COMPLETE )); do
#       prompt_print_debug "Waiting... -> " $COMPLETED '/' $JOBS_TO_COMPLETE
#       sleep 0.1
#     done

#     prompt_print_debug "done waiting..."

#     integer left_length=$(prompt_pure_string_length $LEFT_LINE)
#     integer right_length=$(prompt_pure_string_length $RIGHT_LINE)

#     prompt_print_debug "subtractions..."

#     DISTANCE=$(( $COLUMNS - 1 - $left_length - $right_length ))

#     prompt_print_debug "distance..."

#     # Build the prompt from our components
#     PROMPT='
# '$LEFT_LINE${(l:$DISTANCE:: :)}${RIGHT_LINE}'
# '$get_virtual_env' > '

#     # End of prompt builder
#   }

#   # This used to be a bunch of functions, but now we just added this thing only.
#   # precmd_functions+=(precmd_prompt)

#   # Old recursive updater used: TRAPALRM(). Look up if you want to look at it
#   # }}}
# else  # {{{10
#   zplug 'bhilburn/powerlevel9k', use:powerlevel9k.zsh-theme, nice:-19
# fi

# # {{{10 Powerlevel configuration
# if zplug check bhilburn/powerlevel9k; then
#   ## Powerlevel configuration
#   # Not sure I have the right fonts for this yet...
#   # POWERLEVEL9K_MODE="awesome-patched"
#   POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
#   POWERLEVEL9K_SHORTEN_DELIMITER=""
#   POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

#   POWERLEVEL9K_SHOW_CHANGESE="true"

#   POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#   POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
#   POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="↳ "
#   POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \Uf073 %m-%d-%y}"

#   POWERLEVEL9K_CUSTOM_COMMIT_MESSAGE="get_commit_message"
#   POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
#   POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_commit_message time)
# fi
# # }}}
# # }}}
