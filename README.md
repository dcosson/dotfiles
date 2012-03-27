##My configuration files for vim, bash, and whatever else

###Vim plugins:
First, recompile vim with a bunch of options

    cd ~/src
    hg clone https://vim.googlecode.com/hg/ vim
    cd vim
    ./configure --with-features=huge --enable-perlinterp --enable-pythoninterp --enable-rubyinterp --enable-tclinterp --enable-gui=yes
    sudo mv /usr/bin/vim /usr/bin/vim_original
    sudo make install

Activate the submodules:

    cd ~/config-files/
    git submodule init
    git submodule update
    \# if you don't have pyflakes installed:
    cd vim/bundle/pyflakes-vim
    git submodule init
    git submodule update

Install pep8 (using pip), then symlink from wherever pep8 installed (site-packages or dist-packages) to somewhere on your path like /usr/local/bin/pep8

Taglist plugin requires a different version of ctags (non-emacs).  Compile the source and put it on your path above the default ctags for it to work

###Unversioned plugin notes:
Pathogen is from [https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim](https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim)

python\_pep8.vim is version 1.1 from [http://www.vim.org/scripts/script.php?script_id=3160](http://www.vim.org/scripts/script.php?script_id=3160)
