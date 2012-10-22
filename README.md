##My configuration files for vim, bash, and whatever else it is I use on the computer these days

###Vim:
Make sure vim is compiled with ruby and python support (and you probably also want clipboard, --with-features=huge, etc).

To use these dotfiles:

    # clone the repo
    cd ~/dotfiles
    git submodule update --init
    # symlink or copy the files you want to the right location
    ln -s ~/dotfiles/vimrc ~/.vimrc
    ln -s ~/dotfiles/vim ~/.vim

Install pyflakes & pep8 (using pip), then symlink from wherever they're installed (e.g. site-packages or /usr/local/bin/share/python) to somewhere on your path (like /usr/local/bin)

You need a different version of ctags than the osx default, install it with homebrew

###Unversioned plugin notes:
Pathogen is from [https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim](https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim)

python\_pep8.vim is version 1.1 from [http://www.vim.org/scripts/script.php?script_id=3160](http://www.vim.org/scripts/script.php?script_id=3160)
