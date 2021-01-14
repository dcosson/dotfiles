#!/usr/bin/env bash

# dcosson OSX Defaults
# Forked from ~/.osx — http://mths.be/osx - https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# More options explained http://secrets.blacktree.com/?showapp=.GlobalPreferences

# Bluetooth options https://www.reddit.com/r/apple/comments/5rfdj6/pro_tip_significantly_improve_bluetooth_audio/

# Alert banner options from https://osxdaily.com/2014/01/29/change-notifications-banner-time-mac-os-x/

###
### Alert Banners
###
# Set a long banner notification time because I don't always see it right away.
defaults write com.apple.notificationcenterui bannerTime -int 10

###
### Sound
###

# Bluetooth sound options for SBC codec (shouldn't affect airpods using AAC but other bluetooth headphones. Reset computer to take effect.
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80
# defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80
# defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80
# defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80
# defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80
# defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80

# Here are commands to undo these bluetooth settings if it causes problems:
# defaults delete com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)"
# defaults delete com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)"
# defaults delete com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)"
# defaults delete com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)"
# defaults delete com.apple.BluetoothAudioAgent "Negotiated Bitpool"
# defaults delete com.apple.BluetoothAudioAgent "Negotiated Bitpool Max"
# defaults delete com.apple.BluetoothAudioAgent "Negotiated Bitpool Min"

# Turn off annoying interface sound effects and beeps
defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool false
defaults write NSGlobalDomain com.apple.sound.beep.flash -bool false
defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool false
