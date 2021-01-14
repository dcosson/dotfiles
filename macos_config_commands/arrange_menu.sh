#!/usr/bin/env bash

# dcosson OSX Defaults
# Forked from ~/.osx — http://mths.be/osx - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# More options explained http://secrets.blacktree.com/?showapp=.GlobalPreferences

# Ask for the administrator password upfront
sudo -v

# Hide any icons (Time machine is no longer shown  by default)
# for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#     defaults write "${domain}" dontAutoLoad -array \
#         "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
# done

# Show icons:
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Displays.menu" \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Restart menu bar
killall SystemUIServer
