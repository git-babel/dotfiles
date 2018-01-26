#!/bin/bash

# This script initalize basic setting for programming.
DIRNAME="$(dirname "$0")"
DIR="$(cd "$DIRNAME" && pwd)"

function report_error() {
  echo "$@" 1>&2
}

function config_git() {
  git config --global user.name "Junyoung Lim"
  git config --global user.email tlstjstksth@gmail.com
  git config --global core.editor vim
  git config --global merge.tool vimdiff
}

# Untested.
# TODO :: use symbolic link.
function cp_backup() {
  # Add dot to file.
  DEST=${2:-.$1}

  # FILE exists.
  if [ -e "$HOME/$DEST" ]; then
    # It need gmv; GNU coreutils.
    if gmv --backup=number "$HOME/$DEST" "$HOME/$DEST.old"; then
      echo "Renamed ~/$DEST to ~/$DEST.old"
      if cp "$DIR/$1" "$HOME/$DEST"; then
        echo "Created ~/$DEST"
      else
        report_error "Failed to create ~/$DEST"
      fi
    else
      report_error "Failed to rename ~/$DEST to ~/$DEST.old"
    fi
  else
    if cp "$DIR/$1" "$HOME/$DEST"; then
      echo "Created ~/$DEST"
    else
      report_error "Failed to create ~/$DEST"
    fi
  fi
}

function install_brew() {
  if [ "$(uname)" != "Darwin" ]; then
    echo "it is not OS X. Skip $FUNCNAME"
    return
  fi

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  if [ "$?" !=  "0" ]; then
    report_error "$FUNCNAME is failed."
  else
    echo "brew is successfully installed."
    brew update
  fi
}

function install_coreutils() {
  if [ "$(uname)" = "Darwin" ]; then
    brew install coreutils
  fi

  if [ "$?" !=  "0" ]; then
    report_error "$FUNCNAME is failed."
  else
    echo "coreutils is successfully installed."
  fi
}

function install_pyenv() {
  if [ "$(uname)" = "Darwin" ]; then
    brew install pyenv
    brew install pyenv-virtualenv
  else
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer
  fi

  if [ "$?" !=  "0" ]; then
    report_error "$FUNCNAME is failed."
  else
    echo "pyenv is successfully installed."
  fi
}

function install_zsh() {
  if [ "$(uname)" = "Darwin" ]; then
    brew install zsh
    # TODO :: system zsh choosed as basic shell.
    chsh -s $(which zsh)
    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    cp_backup zshrc
  fi

  # Install powerline fonts
  # 12pt DeVaju San Mono for Powerline
  git clone https://github.com/powerline/fonts.git
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts

  if [ "$?" !=  "0" ]; then
    report_error "$FUNCNAME is failed."
  else
    echo "zsh is successfully installed."
  fi
}

function install_vim() {
  if [ "$(uname)" = "Darwin" ]; then
    brew install vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp_backup vimrc
  fi
}

function install_tmux() {
  if [ "$(uname)" = "Darwin" ]; then
    brew install tmux
    cp_backup tmux.conf
  fi
}

case $1 in
  --all)
    config_git
    install_brew
    install_coreutils
    install_pyenv
    install_zsh
    install_vim
    ;;
  git)
    config_git
    ;;
  brew)
    install_brew
    ;;
  coreutils)
    install_coreutils
    ;;
  pyenv)
    install_pyenv
    ;;
  zsh)
    install_zsh
    ;;
  vim)
    install_vim
    ;;
  tmux)
    install_tmux
    ;;
esac
