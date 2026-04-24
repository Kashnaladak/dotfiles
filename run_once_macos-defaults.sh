#!/bin/bash
# Keyboard: fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Dock: auto-hide, tile size
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 45
killall Dock

# Finder: show hidden files, list view
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
killall Finder

# Screenshots: save to ~/Documents/screenshots/, selection mode
mkdir -p "$HOME/Documents/screenshots"
defaults write com.apple.screencapture location -string "$HOME/Documents/screenshots"
defaults write com.apple.screencapture style -string "selection"
defaults write com.apple.screencapture target -string "file"

# Trackpad: tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
