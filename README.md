## Danny Cosson Dotfiles

My configuration files for my MacOS dev environment.

At the moment it's configuration for bash, vim, git, tmux & screen, and some miscellaneous files (favorite programming fonts, short scripts I've found useful, etc).

### Usage

NB: Note that in gitconfig, my user is set.  So you'll want to change that to you or all your commits will have my name.  Other than that, there's nothing personally tied to me.

`git submodule update --init`

A lot of the vim plugins are linked as submodules

`make_symlinks.sh`

This script symlinks the dotfiles into place. If you have existing dotfiles where they need to go, those will be moved to an `~/old_dotfiles` directory.

`configure_osx_preferences.sh`

This script sets a bunch of system preferences defaults in osx that I like (faster key repeat, icons in menubar, many others).  If you like your system preferences as they are don't run this script.

For Vim powerline to work, you have to install a patched fonts.  Open one of the `*-Powerline.ttf` fonts in `misc/fonts/`, click install, and set that as your font in iterm or terminal or whatever.



### Dependencies (make sure they're on your path)

- `pip install pyflakes pep8`

- `brew install nodejs` and `npm install -g eslint`

- exuberant ctags (not the osx builtin ctags), install it with `brew install ctags`

- vim needs ruby and python support (and you probably also want clipboard, --with-features=huge, etc). See [this gist] (https://gist.github.com/dcosson/3686437) for tips compiling on osx. MacVim probably works too.


## Other OSX Workflow Notes

- use pyenv and `pyenv install 2.7.10` and `pyenv set global 2.7.10` (or some non-osx default version). New El Capitan OSX kernel-level security prevents you from writing to certain paths which "sudo pip install" on the system python will try to write to



###Unversioned plugin notes:

Pathogen is from [https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim](https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim)

python\_pep8.vim is version 1.1 from [http://www.vim.org/scripts/script.php?script_id=3160](http://www.vim.org/scripts/script.php?script_id=3160)

tommorrow-theme colorscheme is from [https://github.com/chriskempson/tomorrow-theme](https://github.com/chriskempson/tomorrow-theme), I made a few customizations to tomorrow-night-dcosson to make it darker
