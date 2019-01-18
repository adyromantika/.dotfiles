#!/bin/bash

if grep -i linux /proc/version >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y zsh zsh-common
elif uname | grep -i darwin >/dev/null 2>&1; then
  if \which brew >/dev/null 2>&1; then
    brew install zsh zsh-completions
  fi
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

mkdir -p ~/.oh-my-zsh/custom/plugins
mkdir -p ~/.oh-my-zsh/custom/themes

mkdir -p ~/.aws/cli

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-aws-vault ]; then
  cd ~/.oh-my-zsh/custom/plugins/zsh-aws-vault && git pull
else
  git clone https://github.com/adyromantika/zsh-aws-vault.git ~/.oh-my-zsh/custom/plugins/zsh-aws-vault
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-nvm ]; then
  cd ~/.oh-my-zsh/custom/plugins/zsh-nvm && git pull
else
  git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
fi

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
  cd ~/.oh-my-zsh/custom/themes/powerlevel9k && git pull
else
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi
