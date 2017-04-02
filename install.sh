#!/bin/bash
# Install stuff in this dotfiles directory

set -e

./configure_osx_preferences.sh
./make_symlinks.sh
