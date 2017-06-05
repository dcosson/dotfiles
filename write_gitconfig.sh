#!/bin/bash
# Creates a .gitconfig that includes the .gitconfig-shared, and asks you to set your name and email.

set -e

read -n1 -p "Set global git settings now? Will write your gitconfig and set your name & email y/n: " var
echo ""

if [ "$var" != "y" ] && [ "$var" != "Y" ]; then
  echo "Exiting without writing ~/.gitconfig (run dotfiles/write_gitconfig.sh to re-run)"
  exit 0
fi

read -p "Name: " user_name
read -p "Email: " user_email

git config --global user.name "$user_name"
git config --global user.email "$user_email"
git config --global core.excludesfile "${HOME}/.gitignore"
git config --global includes.path "${HOME}/.gitconfig-shared"

