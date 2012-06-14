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

# tmux 256 colors hack (wtf, tmux keeps ignoring the term setting in .tmux.conf and insists on setting TERM to "screen")
if [ "$TERM" == "screen" ]
then
    export TERM="screen-256color"
fi

# the classic MySQL library path fix for OSX 
export LD_LIBRARY_PATH=/usr/local/mysql-5.5.19-osx10.6-x86_64/lib
export PATH=$PATH:/usr/local/sbin:/usr/local/mysql/bin

# For VirtualEnvWrapper
export WORKON_HOME=~/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Not sure what this is:
test -r /sw/bin/init.sh && . /sw/bin/init.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi

###
### Some random aliases/functions I find useful
###
alias lsl='ls -G -lh' #b/c I almost always want ls -lh instead of ls
alias grep='grep -i --color=auto'
# rename the current tab in terminal/iterm2
rn() { export PROMPT_COMMAND="echo -ne \"\033]0;$1\007\""; }
# run local mongodb (from /usr/local) and put it in the background
alias mongolocal='sudo mongod run --config /usr/local/etc/mongod.conf --fork && sleep 1 && tail -20 /usr/local/var/log/mongodb/mongod.log'
# for ruby guard gem if using ruby bundler (tracks file differences)
alias guard="bundle exec guard"
# Get a rough outline of a python file - show class & function declarations, block comments, first line of docstrings
pyoutline() { egrep --color=auto '^[\t ]*class|^[\t ]*def|^[\t ]*###.+$|^[\t ]*""".+$' $1; } # apparently \s doesn't work so I use [\t ]


###
### Source custom shortcuts/aliases for specific setups
###
if [ -f ~/.bash_profile_venmo ] ; then
    source ~/.bash_profile_venmo
fi
