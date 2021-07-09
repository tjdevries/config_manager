# I'm going to try and keep these available to use in either bash or zsh
# If they aren't, I should make them differently

print_all_the_colors() {
    for code in {000..255}; do print -P -- "$code: %F{$code}Test%f"; done
}

diff_commit() {
    if [ "$1" != "" ]
    then
        git diff $1~ $1
    else
        git diff HEAD~ HEAD
    fi
}

author_contrib() {
    git log --author="$1" --pretty=tformat: --numstat $2 | \
        gawk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s removed lines: %s total lines: %s\n", add, subs, loc }' -
}


quick_change () {
    echo "Do you want to change?"
    grep -rl "$2" $1
    grep -rl "$2" $1 | xargs sed -i "s/$2/$3/g"
}

pip_update() {
    echo "Updating python packages..."
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}

function cd {
  builtin cd $1

  script_name="$XDG_CONFIG_HOME/cd_scripts/`pwd | xargs basename`"
  if [ -e ${script_name}.zsh ]; then
    source ${script_name}.zsh
  fi
}

function manage {
  cd ~/sourceress;

  python web/manage.py "$@"
}


function generate_attrs {
  python web/manage.py generate_attr_constructors -f $1
}

function dvim {
  nvim -u ~/git/config_manager/test/demo_init.vim $1
}

function demogif {
  local width="${3:=132}"
  local height="${4:=24}"

  # Set terminal size
  printf '\033[8;'$height';'$width't'

  termtosvg -g "$width"x"$height" $2 -c "nvim -u ~/git/config_manager/test/demo_init.vim $1"
}

function nvimgif {
  local width="${3:=132}"
  local height="${4:=24}"

  # Set terminal size
  printf '\033[8;'$height';'$width't'

  termtosvg -g "$width"x"$height" $2 -c "nvim $1"
}

export DEFAULT_VIDEO="/dev/video0"
function list_vid_option {
  v4l2-ctl --list-ctrls -d $DEFAULT_VIDEO
}

function set_vid_option {
  v4l2-ctl -d $DEFAULT_VIDEO --set-ctrl $1=$2
}

function setup_js {
  export NVM_COMPLETION=true
  export NVM_DIR=$HOME/".nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

  if hash yarn 2>/dev/null; then
      export PATH="$PATH:$(yarn global bin)"
  fi
}
