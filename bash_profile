###
### General bash Settings
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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

###
### Prompt
###

# Show current git/svn project info in prompt
parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
parse_svn_branch() {
  svn info 2> /dev/null | grep URL | sed -e "s/.*\/\(.*\)$/(\1)/"
}
gemset_info() {
  rvm info | egrep '^ruby' | grep '@' | sed -e 's/^\(.*\)@\(.*\):$/(@\2) /'
}
# set up colors
txtblack='\[\033[0;30m\]'
txtred='\[\033[0;31m\]'
txtgreen='\[\033[0;32m\]'
txtorange='\[\033[0;33m\]'
txtblue='\[\033[0;34m\]'
txtpurple='\[\033[0;35m\]'
txtwhite='\[\033[0;37m\]'
txtend='\[\033[0m\]'


SMILEY_IF_SUCCESS="\`if [ \$? = 0 ]; then echo -e '${txtgreen}:)${txtend}'; else echo -e '${txtred}:(${txtend}'; fi\`"
SUNNY_IF_SUCCESS="\`if [ \$? = 0 ]; then echo -e '${txtgreen}☀${txtend}'; else echo -e '${txtblue}☁${txtend}'; fi\`"

PS1="\n\
${txtgreen}\u$DIM${txtend} ${txtwhite}@${txtend} ${txtorange}\h${txtend} ${txtblue}\$(gemset_info)${txtend}$SUNNY_IF_SUCCESS
${txtpurple}\$PWD${txtend} ${txtwhite}\$(parse_git_branch)\$(parse_svn_branch)\$ "  # don't end color, I want my text white
export PS1

# tmux 256 colors hack (wtf, tmux keeps ignoring the term setting in .tmux.conf and insists on setting TERM to "screen")
if [ "$TERM" == "screen" ]
then
    export TERM="screen-256color"
fi


###
### Path-ey things
###
# the classic MySQL library path fix for OSX  (un-comment if installing mysql)
# export LD_LIBRARY_PATH=/usr/local/mysql-5.5.19-osx10.6-x86_64/lib
export PATH=/usr/local/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/python/

# For VirtualEnvWrapper
export WORKON_HOME=~/virtualenvs
source /usr/local/share/python/virtualenvwrapper.sh

# brew bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi

# EC2 Command Line Tools
export JAVA_HOME="`/usr/libexec/java_home -v 1.6`"
export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"


###
### Some random aliases/functions I find useful
###
alias lsl='ls -G -lh' #b/c I almost always want ls -lh instead of ls
alias grep='grep -i --color=auto'
alias gg='git grep -n --color --heading --break'
alias .b='source ~/.bash_profile'

# rename the current tab in terminal/iterm2
rn() { export PROMPT_COMMAND="echo -ne \"\033]0;$1\007\""; }
# run local mongodb (from /usr/local) and put it in the background
alias mongolocal='sudo mongod run --config /usr/local/etc/mongod.conf --fork && sleep 1 && tail -20 /usr/local/var/log/mongodb/mongod.log'

# Get a rough outline of a python file - show class & function declarations, block comments, first line of docstrings
pyoutline() { egrep --color=auto '^[\t ]*class|^[\t ]*def|^[\t ]*###.+$|^[\t ]*""".+$' $1; } # apparently \s doesn't work so I use tab or space
wcr() { wc -l `find . -type f | egrep "$1$"`; } # recursive word count, pass in the file extension
alias ip='curl icanhazip.com'

# toggle show/hide hidden files in Finder
alias showhidefileson='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias showhidefilesoff='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'

# create an empty new bash script
bashscript() { touch $1; chmod a+x $1; echo -e "#!/bin/bash\n\n" > $1; vim $1; }

###
### Source custom shortcuts/aliases for specific/private setups
###
if [ -f ~/.bash_profile_extensions ] ; then
   source ~/.bash_profile_extensions
fi

if [ -f ~/.bash_profile_venmo ] ; then
    source ~/.bash_profile_venmo
fi

