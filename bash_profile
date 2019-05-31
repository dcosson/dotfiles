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
export PATH=/usr/local/bin:$PATH:/usr/local/sbin:$HOME/.rvm/bin:/usr/local/mysql/bin:/usr/local/share/npm/bin:~/.ec2/bin

# VirtualEnvWrapper
export WORKON_HOME=~/virtualenvs
[ -f /usr/local/bin/virtualenvwrapper.sh ] && \. /usr/local/bin/virtualenvwrapper.sh

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; fi

# nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# rvm
[ -d $HOME/.rvm ] && \. $HOME/.rvm/scripts/rvm

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# go path
export GOPATH=$HOME/go

# generate ctags in different languages
alias ctags_ruby='ctags -R --languages=ruby --exclude=.git --exclude=vendor/bundle --exclude=node_modules --exclude=coverage'
alias ctags_python='ctags -R --languages=python --exclude=.git --exclude=node_modules --exclude=coverage'

# fzf (fuzzy file finder) option for vim - use ag as search source (which ignores .gitignore and .agignore files)
export FZF_DEFAULT_COMMAND='ag -g ""'

# Bash Completion
# This is where the older bash_completion wrapper script lived
if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi
# This is the newer script for bash-completion@2
if [ -f `brew --prefix`/share/bash-completion/bash_completion ]; then
. `brew --prefix`/share/bash-completion/bash_completion
fi

# aws completion
if [ -f `brew --prefix`/bin/aws_completer ]; then
complete -C aws_completer aws
fi

### Docker helpers
alias dk='docker-compose'

# Compare sha256 hashes of two files
filehashcmp() {
    hash1="$(shasum -a 256 "$1" | awk '{print $1}')"
    hash2="$(shasum -a 256 "$2" | awk '{print $1}')"
    if [ "$hash1" == "$hash2" ]; then echo "Files are the same"; else echo "Not the same"; fi
}

### Source another bash file for storing more specific local setup stuff
if [ -f ~/.bash_profile_extensions ] ; then
   source ~/.bash_profile_extensions
fi

if [ -f ~/.bash_secrets ] ; then
   source ~/.bash_secrets
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
