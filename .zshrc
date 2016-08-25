# Path to your oh-my-zsh installation.
export ZSH=/Users/brent/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER="brent"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/Users/brent/bin:/Users/brent/.composer/vendor/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/brent/Documents/android-sdk/platform-tools:/Users/brent/Documents/android-sdk/tools"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#!/bin/bash

function zap() {
    USAGE="Usage: zap [remember|to|forget|locations] [bookmark]" ;
    if  [ ! -e ~/.bookmarks ] ; then
        mkdir ~/.bookmarks
    fi

    case $1 in
        # create bookmark
        remember) shift
            if [ ! -f ~/.bookmarks/$1 ] ; then
                echo "cd `pwd`" > ~/.bookmarks/"$1" ;
                echo "OK, I'll remember it." ;
            else
                echo "There is already a bookmark named '$1'."
            fi
            ;;
        # goto bookmark
        to) shift
            if [ -f ~/.bookmarks/$1 ] ; then
                source ~/.bookmarks/"$1"
            else
                echo "This bookmark's location has been lost to the void." ;
            fi
            ;;
        # delete bookmark
        forget) shift
            if [ -f ~/.bookmarks/$1 ] ; then
                rm ~/.bookmarks/"$1" ;
                echo "The '$1' bookmark has been forgotten." ;
            else
                echo "I can't find a bookmark with that name." ;
            fi
            ;;
        # list bookmarks
        locations) shift
            ls -l ~/.bookmarks/ ;
            ;;
         *) echo "$USAGE" ;
            ;;
    esac
}

# iTerm2 window/tab color commands
#   Requires iTerm2 >= Build 1.0.0.20110804
#   http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# Change the color of the tab when using SSH
# reset the color after the connection closes
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "production|ec2-.*compute-1" ]]; then
            tab-color 255 0 0
        else
            tab-color 0 255 0
        fi
    fi
    ssh $*
}
compdef _ssh color-ssh=ssh


alias ssh=color-ssh
alias chrome='open -a Google\ Chrome'
alias sb='ssh serveradmin@siteburst.net@siteburst.net -i ~/.ssh/mykey'
#alias web9='ssh bgarner@calweb9ap01.fglsports.dmz -i ~/.ssh/mykey'
#alias web8='ssh bgarner@calweb8ap01.fglsports.com -i ~/.ssh/mykey'
#alias mysql1='ssh bgarner@calmys1db01.fglsports.dmz -i ~/.ssh/mykey'
alias web9='ssh bgarner@calweb9ap01.fglsports.dmz'
alias web8='ssh bgarner@calweb8ap01.fglsports.com'
alias mysql1='ssh bgarner@calmys1db01.fglsports.dmz'

alias codecept='vendor/bin/codecept'
alias pa='php artisan'

alias gs='git status'
alias ga='git add .'
alias gc='git commit -m '

alias gl='git log --pretty=format:"%h - %an, %ar : %s"'

alias git-remove='git rm $(git ls-files --deleted)'
alias git-prune="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"
alias git-del-merged-branches="git branch -D `git branch --merged | grep -v \* | xargs`"

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}
