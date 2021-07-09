# Basic functions
alias gs='git status'
alias gpull='git pull'
alias gpush='git push'
alias gd='git diff'
alias gpr='git pull --rebase'

# Adding helpers
alias gadd='git add .'
alias gca='git add . && git commit -av'

# Logging helpers
alias gls='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias gdate='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'
alias gdatelong='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'

# Branch helpers
__new_branch() { git checkout -b $1 }
alias gbn=__new_branch

# File searching
search_top_level() {
    A=$(pwd)
    TOPLEVEL=$(git rev-parse --show-toplevel)
    cd $TOPLEVEL
    MY_RESULT="$(git grep --full-name -In $1)"
    py_script="
search_string = \"$1\"
bash = \"\"\"$MY_RESULT\"\"\"
CSI='\x1B['
reset = CSI + 'm'
bash = bash.replace(search_string, CSI + '91;40m' + search_string + reset)
bash_split = ['File Name:#:Result'] + bash.split('\n')
name_len = 0
line_len = 0
for line in bash_split:
    this_line = line.split(':')
    temp_name = this_line[0]
    temp_line = this_line[1]
    name_len = max(len(temp_name), name_len)
    line_len = max(len(temp_line), line_len)

to_print = '{0:<%d} | {1:>%d} | {2}' % (name_len, line_len)
for line in bash_split:
    this_line = line.split(':')
    temp_name = this_line[0]
    temp_line = this_line[1]
    print(to_print.format(temp_name, temp_line, ' '.join(this_line[2:])))
"
python3 -c "$py_script"
cd $A
}

alias gsearch=search_top_level
alias gfind='git ls-files | grep -i'

# Switching contexts
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "[WIP]: $(date)"'

# Oops savers
alias gundo='git reset HEAD~'


# Rebase master onto current branch
gmrebase() {
    echo "==> Checking out master..."
    git checkout master
    echo ""
    echo "==> Updating master..."
    git pull
    echo ""
    echo "==> Checking back to original branch"
    git checkout -
    echo ""
    echo "==> Rebasing master onto $(git rev-parse --abbrev-ref HEAD)"
    git rebase master $(git rev-parse --abbrev-ref HEAD)
    echo ""
}

gnrebase() {
    echo "==> Checking out main..."
    git checkout main
    echo ""
    echo "==> Updating main..."
    git pull
    echo ""
    echo "==> Checking back to original branch"
    git checkout -
    echo ""
    echo "==> Rebasing main onto $(git rev-parse --abbrev-ref HEAD)"
    git rebase main $(git rev-parse --abbrev-ref HEAD)
    echo ""
}


gpo() {
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
}

cdr() { cd $(git rev-parse --show-toplevel) }
