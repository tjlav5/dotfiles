#!/bin/bash
CUSTOMIZE_TPM="tpm"
CUSTOMIZE_VUNDLE="vundle"
CUSTOMIZE_ZSH="zsh"

CUSTOMIZE=$(whiptail --title "Test Checklist Dialog" --checklist \
  "Customize installation" 15 60 4 \
  "$CUSTOMIZE_TPM" "Tmux Package Manager" OFF \
  "$CUSTOMIZE_VUNDLE" "Vim Vundle" OFF \
  "$CUSTOMIZE_ZSH" "ZSH Antigen" ON \
  3>&1 1>&2 2>&3)

exitstatus=$?
if [ ! $exitstatus = 0 ]; then
  echo "OK, goodbye."
  exit
fi


if [[ $CUSTOMIZE == *"$CUSTOMIZE_VUNDLE"* ]]; then
  echo 'Updating vim plugins...'
  dir=~/.vim/bundle/Vundle.vim
  if [ ! -d "$dir" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $dir
  fi
  vim -c VundleUpdate -c quitall > /dev/null
fi


if [[ $CUSTOMIZE == *"$CUSTOMIZE_TPM"* ]]; then
  echo 'Updating tmux plugins...'
  dir=~/.tmux/plugins/tpm
  if [ ! -d "$dir" ]; then
    git clone https://github.com/tmux-plugins/tpm $dir
  fi
  $dir/bin/install_plugins
  tmux source ~/.tmux.conf
fi


if [[ $CUSTOMIZE == *"$CUSTOMIZE_ZSH"* ]]; then
  echo 'Updating zsh plugins...'
  dir=~/antigen
  if [ ! -d "$dir" ]; then
    git clone https://github.com/zsh-users/antigen.git ~/antigen
  fi
  source ~/.zshrc
fi


echo "FIN."
