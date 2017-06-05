## Danny Cosson Dotfiles

Configuration files for my dev environment.

Contains configuration for bash, vim, git, tmux, and some miscellaneous files (favorite programming fonts, short scripts I've found useful, etc).

### Usage

There's nothing personally tied to me (user name, email, etc.) so these dotfiles can be forked and re-used for you as-is. The install script has an interactive step to set personal global git variables like name and email.

`install.sh` - symlinks all dotfiles into place, and interactively sets up your global git config.

`configure_osx_preferences.sh` - configures system preferences in a more developer-friendly way (things like fast key repeat, less annoying menu bar, Finder options, no time machine, etc.)

Run `PlugInstall` inside of vim to install [vim-plug](https://github.com/junegunn/vim-plug) plugins.


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
