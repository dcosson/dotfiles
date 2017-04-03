## Danny Cosson Dotfiles

Configuration files for my dev environment.

At the moment it's configuration for bash, vim, git, tmux, and some miscellaneous files (favorite programming fonts, short scripts I've found useful, etc).

### Usage

NB: Note that in gitconfig, my username is set.  So you'll want to change that to you or all your commits will have my name.  Other than that, there's nothing personally tied to me.

`make_symlinks.sh` - symlinks all dotfiles into place

`configure_osx_preferences.sh` - configures system preferences how I like them (things like fast key repeat, incons in menu bar, Finder options, etc.)


### Dependencies (make sure they're on your path)

- `pip install flake8`

- `brew install nodejs` and `npm install -g eslint`

- exuberant ctags (not the osx builtin ctags), install it with `brew install ctags`

- vim needs ruby and python support, best to not use pre-installed version and just `brew install vim`

- Install fonts with `brew tap caskroom/fonts` and `brew cask install font-inconsolata font-inconsolata-for-powerline`. The vim-powerline plugin needs the "-for-powerline" version of whatever font you use.


## Other OSX Workflow Notes

Avoid system language binaries for python & ruby (they're installed globally so you'll have to sudo install things, and there are some new as of El Capitan kernel-level security that will prevent even sudo from writing to certain paths that pip install might try to write to).

Instead:

``` bash
brew install pyenv rbenv
# find latest released version of ruby
rbenv install --list | grep '^\s*2.' | grep -v preview | grep -v dev | tail -1
# now whatever that output was, rbenv install that version e.g.
rbenv install 2.3.3

# find latest released version of python 2.7.x
pyenv install --list | grep '^\s*2.7' | grep -v preview | grep -v dev | tail -1
# now whatever that output was, rbenv install that version e.g.
rbenv install 2.7.11
```

Now, for one-off pip or gem global libraries you need to install, you'll never need `sudo`.
