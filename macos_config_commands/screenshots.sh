#!/usr/bin/env bash

# dcosson OSX Defaults
# Forked from ~/.osx — http://mths.be/osx - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# More options explained http://secrets.blacktree.com/?showapp=.GlobalPreferences

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# And save them to the ~/Screenshots directory
defaults write com.apple.screencapture type -string "png"
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots
