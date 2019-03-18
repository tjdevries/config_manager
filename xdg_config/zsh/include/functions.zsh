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
