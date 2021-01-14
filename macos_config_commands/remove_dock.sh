#!/usr/bin/env bash

# dcosson OSX Defaults
# Forked from ~/.osx — http://mths.be/osx - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# More options explained http://secrets.blacktree.com/?showapp=.GlobalPreferences

# The dock only ever gets in the way on my desktop, I want it effectively removed. I just open mission control if I need to access it. Since it's not possible to remove it fully, set it to a very long delay (10 seconds) so I won't accidentally trigger it.

# Dock on the right
defaults write com.apple.dock orientation -string "right" 

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# 10 second delay
defaults write com.apple.dock autohide-delay -float "10.0"

# Small amount of dock magnification on hover
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -float "50.0"

killall Dock
