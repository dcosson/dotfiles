#!/usr/bin/env bash

# dcosson OSX Defaults
# Forked from ~/.osx — http://mths.be/osx - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# More options explained http://secrets.blacktree.com/?showapp=.GlobalPreferences

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
