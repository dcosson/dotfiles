###
### General Settings
###
alias ls='ls -G'
export PS1="\h:\w$ "
export EDITOR=vim
HISTFILESIZE=100000000
HISTSIZE=100000
shopt -s histappend
PROMPT_COMMAND='history -a'

# up arrow bash history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Show current git/svn project info in prompt
parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
parse_svn_branch() {
        svn info 2> /dev/null | grep URL | sed -e "s/.*\/\(.*\)$/(\1)/"
}
PS1="\n\
\[\033[0;32m\]\u$DIM \[\033[0;37m\]@ \[\033[0;33m\]\h 
\[\033[0;35m\]\$PWD \[\033[0;37m\]\$(parse_git_branch)\$(parse_svn_branch)$ "
export PS1

# tmux 256 colors hack (tmux keeps ignoring the setting in .tmux.conf and insists on setting TERM to "screen")
if [ "$TERM" == "screen" ]
then
    export TERM="screen-256color"
fi

# For VirtualEnvWrapper
export WORKON_HOME=~/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Not sure:
test -r /sw/bin/init.sh && . /sw/bin/init.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi

source ~/.bash_profile_venmo
