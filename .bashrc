export BASH_SILENCE_DEPRECATION_WARNING=1

# PS1 stuff #############################################
#Regular text color
BLACK='\[\e[0;30m\]'
#Bold text color
BBLACK='\[\e[1;30m\]'
#background color
BGBLACK='\[\e[40m\]'
RED='\[\e[0;31m\]'
BRED='\[\e[1;31m\]'
BGRED='\[\e[41m\]'
GREEN='\[\e[0;32m\]'
BGREEN='\[\e[1;32m\]'
BGGREEN='\[\e[1;32m\]'
YELLOW='\[\e[0;33m\]'
BYELLOW='\[\e[1;33m\]'
BGYELLOW='\[\e[1;33m\]'
BLUE='\[\e[0;34m\]'
BBLUE='\[\e[1;34m\]'
BGBLUE='\[\e[1;34m\]'
MAGENTA='\[\e[0;35m\]'
BMAGENTA='\[\e[1;35m\]'
BGMAGENTA='\[\e[1;35m\]'
CYAN='\[\e[0;36m\]'
BCYAN='\[\e[1;36m\]'
BGCYAN='\[\e[1;36m\]'
WHITE='\[\e[0;37m\]'
BWHITE='\[\e[1;37m\]'
BGWHITE='\[\e[1;37m\]'

COOLGREEN='\[\e[38;5;22m\]'
COOLBROWN='\[\e[38;5;94m\]'
COOLGRAY='\[\e[38;5;8m\]'
COOLBLUE='\[\e[38;5;19m\]'
COOLPINK='\[\e[38;5;207m\]'

PROMPT_COMMAND=smile_prompt

parse_git_branch() {
    git branch --show-current 2> /dev/null | cut -c1-8
}
function smile_prompt
{
    if [ "$?" -eq "0" ]
    then
        #smiley
        SC="${GREEN}$?"
    else
        #frowney
        SC="${RED}$?"
    fi
    if [ $UID -eq 0 ]
    then
        #root user color
        UC="${RED}"
    else
        #normal user color
        UC="${COOLGREEN}"
    fi
    # Git branch color
    GB="${COOLPINK}"
    #hostname color
    HC="${CYAN}"
    #regular color
    RC="${COOLGRAY}"
    #default color
    DF='\[\e[0m\]'
    PS1="[${UC}\u${RC}@${HC}\h ${RC}\W${DF} ${GB}$(parse_git_branch)${DF}] ${SC}${DF} "
}

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# PS1 stuff #############################################

# GIT stuff #############################################

alias gb="git branch --show-current"
alias gpl="git pull"
alias gs="git status"
alias gco="git checkout"


function clean_stale_branches() {
    git fetch --all --prune
    local_branches=$(git branch -vv | grep ': gone]' | awk '{print $1}')

    read -p "Are you sure you want to delete the following branches: ${local_branches}? [y/N] " confirm_delete
    if [[ $confirm_delete =~ ^[Yy]$ ]]
    then
        # Delete the local branches that don't exist on remote
        git branch -D $local_branches
    else
        echo "Aborted deletion of local branches"
    fi
}

# GIT stuff #############################################
function frick () {
    TF_PYTHONIOENCODING=$PYTHONIOENCODING;
    export TF_SHELL=bash;
    export TF_ALIAS=frick;
    export TF_SHELL_ALIASES=$(alias);
    export TF_HISTORY=$(fc -ln -10);
    export PYTHONIOENCODING=utf-8;
    TF_CMD=$(
    thefuck THEFUCK_ARGUMENT_PLACEHOLDER "$@"
    ) && eval "$TF_CMD";
    unset TF_HISTORY;
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
    history -s "$TF_CMD";
}


source ~/.git-completion.bash

# Don't remember why I need this
eval "$(/opt/homebrew/bin/brew shellenv)"

# Connect to UTDC VPN
conn_vpn() {
    networksetup -connectpppoeservice "UTDC VPN"
    until networksetup -showpppoestatus "UTDC VPN" | grep -q "connected"; do
        sleep 1
    done
    echo "Connected to UTDC VPN"
}
cddns() {
    cd ~/hs/hs_static_dns/
}
PATH=$(pyenv root)/shims:$PATH
