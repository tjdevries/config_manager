# .zshenv is always sourced.
# Most ${ENV_VAR} variables should be saved here.
# It is loaded before .zshrc

export ZDOTDIR=$HOME/.config/zsh

export XDG_CONFIG_HOME=$HOME/.config/

export fpath=(~/.config/zsh/completions/ $fpath)

if [[ $s(command -v rg) ]]; then
    export FZF_DEFAULT_COMMAND='rg --hidden --ignore .git -g ""'
fi


# Determine if we are an SSH connection
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    export IS_SSH=true
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) IS_SSH=true
    esac
fi

# TODO: Should I move this to here from zsh_rc?
# if [[ -f "$HOME/.zsh_local" ]]; then
#     source ~/.zsh_locanl
# fi
if [ -e /home/tj/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tj/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
