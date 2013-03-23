###
### OSX-specific .bash_profile
###
HISTFILESIZE=100000000
HISTSIZE=100000

### Source my general (osx or linux) bash setup
[[ -f ~/.bash_includes ]] && source ~/.bash_includes

###
### Path-ey things
###
# the classic MySQL library path fix for OSX  (un-comment if installing mysql)
# export LD_LIBRARY_PATH=/usr/local/mysql-5.5.19-osx10.6-x86_64/lib
export PATH=/usr/local/bin:$PATH:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/python/

# VirtualEnvWrapper
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


### OSX-specific aliases
# run local mongodb (from /usr/local) and put it in the background
alias mongolocal='sudo mongod run --config /usr/local/etc/mongod.conf --fork && sleep 1 && tail -20 /usr/local/var/log/mongodb/mongod.log'

# toggle show/hide hidden files in Finder
alias showhidefileson='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias showhidefilesoff='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'

### Source other bash files with specific/private setups
if [ -f ~/.bash_profile_extensions ] ; then
   source ~/.bash_profile_extensions
fi

if [ -f ~/.bash_profile_venmo ] ; then
    source ~/.bash_profile_venmo
fi
