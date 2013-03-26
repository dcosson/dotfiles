## Danny Cosson Dotfiles

My configuration files for vim, bash, and whatever else it is I use on the computer these days.  I use them both on OSX locally and on linux servers (using the bashrc\_linux file as .bashrc, without .bash\_profile)

At the moment it's configuration for bash, vim, git, tmux & screen, and some miscellaneous files (some nice programming fonts, short scripts I've found useful, etc).

### Usage

`./install.sh`

It inits git submodules and symlinks the dotfiles into place. If you have existing dotfiles where they need to go, those will be moved to an `~/old_dotfiles` directory.

For Vim powerline to work, you have to install a patched fonts.  Open one of the `*-Powerline.ttf` fonts in `misc/fonts/`, click install, and set that as your font in iterm or terminal or whatever.



### Dependencies

- pypi packages `pyflakes` & `pep8` for python formatting. Make sure they're on your path (if you use homebrew python, install with pip and you'll be fine).

- exuberant ctags (not the osx builtin ctags), install it with `brew install ctags`

- vim needs ruby and python support (and you probably also want clipboard, --with-features=huge, etc). See [this gist] (https://gist.github.com/dcosson/3686437) for tips compiling on osx. MacVim probably works too.



###Unversioned plugin notes:

Pathogen is from [https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim](https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim)

python\_pep8.vim is version 1.1 from [http://www.vim.org/scripts/script.php?script_id=3160](http://www.vim.org/scripts/script.php?script_id=3160)

tommorrow-theme colorscheme is from [https://github.com/chriskempson/tomorrow-theme](https://github.com/chriskempson/tomorrow-theme), I made a few customizations to tomorrow-night-dcosson to make it darker
