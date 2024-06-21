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
# rbenv
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; eval "$(pyenv virtualenv-init -)"; fi

# nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

# nvm
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"  # This loads nvm
[ -s "$HOME/.nvm/bash_completion" ] && \. "$HOME/.nvm/bash_completion"  # This loads nvm bash_completion

# rvm
[ -d $HOME/.rvm ] && \. $HOME/.rvm/scripts/rvm

# go path
export GOPATH=$HOME/go

# generate ctags in different languages
alias ctags_ruby='ctags -R --languages=ruby --exclude=.git --exclude=vendor/bundle --exclude=node_modules --exclude=coverage'
alias ctags_python='ctags -R --languages=python --exclude=.git --exclude=node_modules --exclude=coverage'

# fzf (fuzzy file finder) option for vim - use ag as search source (which ignores .gitignore and .agignore files)
export FZF_DEFAULT_COMMAND='ag -g ""'

# Bash Completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# aws completion
if [ -f `brew --prefix`/bin/aws_completer ]; then
complete -C aws_completer aws
fi

### Docker helpers
alias dk='docker-compose'

### Ruby/rails helpers
alias be='bundle exec'

# Compare sha256 hashes of two files
filehashcmp() {
    hash1="$(shasum -a 256 "$1" | awk '{print $1}')"
    hash2="$(shasum -a 256 "$2" | awk '{print $1}')"
    if [ "$hash1" == "$hash2" ]; then echo "Files are the same"; else echo "Not the same"; fi
}

# Enter current directory/project's virtualenv
alias venvactivate='source $([ -d .env3 ] && printf ".env3" || printf ".virtualenv")/bin/activate'

### Source another bash file for storing more specific local setup stuff
if [ -f ~/.bash_profile_extensions ] ; then
   source ~/.bash_profile_extensions
fi

if [ -f ~/.bash_secrets ] ; then
   source ~/.bash_secrets
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
