#!/bin/bash

# Bootstrap the basics I expect on any machine, work or personal: a package
# manager, the CLI tools I reach for constantly, the language toolchains, and the
# zsh environment that zshrc configures but this repo does not contain.
#
# This is a bootstrap, NOT a declarative manifest of the machine. It gets a fresh
# box to the point where the shell works and the usual commands exist; anything
# project- or job-specific gets installed as needed. Edit the arrays freely.
#
# Idempotent throughout — anything already present is skipped, so re-running is
# cheap and safe.
#
# Kept separate from install_make_symlinks.sh deliberately: that script is
# offline, instant and idempotent, while this one needs the network and can fail.

set -e

# brew_install <formula>... — install each formula unless it's already there.
brew_install() {
  local f
  for f in "$@"; do
    if brew list --formula "$f" >/dev/null 2>&1; then
      echo "already installed: $f"
    else
      echo "installing: $f"
      brew install "$f"
    fi
  done
}

# git_clone_once <url> <dest> — shallow clone unless dest already exists.
git_clone_once() {
  local url="$1" dest="$2"
  if [ -d "${dest}" ]; then
    echo "already installed: $(basename "${dest}")"
    return
  fi
  echo "cloning $(basename "${dest}")"
  mkdir -p "$(dirname "${dest}")"
  git clone --depth=1 "${url}" "${dest}"
}

###
### Package Managers
###

echo "==> homebrew"
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Not on PATH in this shell yet; zshrc handles it for later sessions.
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  echo "already installed: $(command -v brew)"
fi

###
### System Tools
###

echo
echo "==> system tools"
# git explicitly: brew's is newer than the Xcode one, and `fzf` here is what makes
# zshrc's fzf plugin and fzf-tab work at all.
brew_install \
  git \
  coreutils \
  fzf \
  jq \
  tree \
  gh \
  neovim \
  the_silver_searcher

###
### Programming Languages
###

echo
echo "==> languages and runtimes"
brew_install \
  go \
  bun \
  uv

echo
echo "==> rust"
# Via rustup rather than brew: brew's rust is a bare toolchain with no way to
# manage channels or targets.
if command -v rustup >/dev/null 2>&1 || [ -x "${HOME}/.cargo/bin/rustup" ]; then
  echo "already installed: rustup"
else
  # --no-modify-path because zshrc already sources ~/.cargo/env.
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

echo
echo "==> anyenv + per-language version managers"
brew_install anyenv
if command -v anyenv >/dev/null 2>&1; then
  # anyenv needs its manifest checked out once before it can install anything.
  if [ ! -d "${HOME}/.config/anyenv/anyenv-install" ]; then
    echo y | anyenv install --init
  fi
  for env in pyenv nodenv; do
    if [ -d "${HOME}/.anyenv/envs/${env}" ]; then
      echo "already installed: ${env}"
    else
      echo "installing: ${env}"
      anyenv install "${env}"
    fi
  done
else
  echo "anyenv not on PATH yet — open a new shell and re-run to get pyenv/nodenv"
fi

###
### Zsh Setup
###

echo
echo "==> zsh environment"
# zshrc sets ZSH_THEME=powerlevel10k and lists its plugins, but the repo carries
# none of that code, so without this a fresh machine gets:
#   .zshrc:85: no such file or directory: ~/.oh-my-zsh/oh-my-zsh.sh
ZSH_DIR="${HOME}/.oh-my-zsh"
CUSTOM="${ZSH_DIR}/custom"

# KEEP_ZSHRC=yes is the important flag. The upstream installer REPLACES ~/.zshrc
# with its own template by default, which would silently delete the symlink
# install_make_symlinks.sh creates and disconnect the shell from this repo.
# RUNZSH=no stops it exec'ing a shell; CHSH=no leaves the login shell alone.
if [ ! -d "${ZSH_DIR}" ]; then
  echo "installing oh-my-zsh into ${ZSH_DIR}"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "already installed: oh-my-zsh"
fi

# Theme and plugins named by zshrc's ZSH_THEME / plugins=(...). Keep this list and
# that one in sync — a plugin listed there but missing here is a startup error.
git_clone_once https://github.com/romkatv/powerlevel10k.git       "${CUSTOM}/themes/powerlevel10k"
git_clone_once https://github.com/Aloxaf/fzf-tab.git              "${CUSTOM}/plugins/fzf-tab"
git_clone_once https://github.com/zsh-users/zsh-autosuggestions.git    "${CUSTOM}/plugins/zsh-autosuggestions"
git_clone_once https://github.com/zsh-users/zsh-syntax-highlighting.git "${CUSTOM}/plugins/zsh-syntax-highlighting"

# powerlevel10k shells out to a gitstatusd binary for the prompt's git segment and
# fetches it lazily on first prompt, which surfaces as "gitstatus failed to
# initialize" until it lands. Fetch it up front so the first prompt is correct.
if [ -x "${CUSTOM}/themes/powerlevel10k/gitstatus/install" ]; then
  if ls "${HOME}"/.cache/gitstatus/gitstatusd-* >/dev/null 2>&1; then
    echo "already installed: gitstatusd"
  else
    echo "fetching gitstatusd for powerlevel10k"
    "${CUSTOM}/themes/powerlevel10k/gitstatus/install"
  fi
fi

# zshrc sources ~/.bun/_bun for completions; homebrew puts it in its own
# site-functions, so point at that rather than leaving the line dead.
if command -v bun >/dev/null 2>&1; then
  brew_bun_completion="$(brew --prefix)/share/zsh/site-functions/_bun"
  if [ -f "${brew_bun_completion}" ] && [ ! -e "${HOME}/.bun/_bun" ]; then
    mkdir -p "${HOME}/.bun"
    ln -sf "${brew_bun_completion}" "${HOME}/.bun/_bun"
    echo "linked bun completions"
  else
    echo "already installed: bun completions"
  fi
fi

echo
echo "done. Open a new shell, or run: exec zsh"
