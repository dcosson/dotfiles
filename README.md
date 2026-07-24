## Danny Cosson Dotfiles

Configuration files for my dev environment.

Contains configuration for bash, vim, git, tmux, and some miscellaneous files (favorite programming fonts, short scripts I've found useful, etc).

### Usage

There's nothing personally tied to me (user name, email, etc.) so these dotfiles can be forked and re-used for you as-is. The install script has an interactive step to set personal global git variables like name and email.

There is no single `install.sh` — run these individually, in this order:

`install_make_symlinks.sh` - symlinks all dotfiles into place (backing up anything already there to `old_dotfiles/`), plus the nvim and ghostty configs that don't fit the `~/.<name>` pattern.

`install_base_system_tools.sh` - bootstraps the basics expected on any machine, in four sections: **Package Managers** (homebrew), **System Tools** (git, coreutils, fzf, jq, tree, gh, neovim, ag), **Programming Languages** (go, bun, uv, rust via rustup, anyenv + pyenv + nodenv), and **Zsh Setup** (oh-my-zsh, powerlevel10k, `fzf-tab`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, gitstatusd, bun completions).

It's a bootstrap, not a declarative manifest — edit the arrays at the top to taste. Idempotent, so re-running is a ~5s no-op. Without it a fresh machine gets `.zshrc:85: no such file or directory: ~/.oh-my-zsh/oh-my-zsh.sh` and no prompt, because `zshrc` configures the theme and plugins but the repo doesn't carry their code.

Do not run the upstream oh-my-zsh installer directly — it replaces `~/.zshrc` unless `KEEP_ZSHRC=yes` is set, which would delete the symlink from the step above and silently disconnect your shell from this repo.

The zsh plugin list in `zshrc` and the clone list in this script have to stay in sync: a plugin named in one but missing from the other is a shell startup error.

`install_write_gitconfig.sh` - interactively sets your global git name and email, and writes a `~/.gitconfig` that includes `~/.gitconfig-shared` for the aliases. `~/.gitconfig` is intentionally a real file, not a symlink, so identity stays per-machine while aliases stay shared.

`install_configure_macos_preferences.sh` - configures system preferences in a more developer-friendly way (things like fast key repeat, less annoying menu bar, Finder options, no time machine, etc.)

Run `PlugInstall` inside of vim to install [vim-plug](https://github.com/junegunn/vim-plug) plugins.


### Dependencies (make sure they're on your path)

Most of these are handled by `install_base_system_tools.sh`. What it doesn't cover:

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
