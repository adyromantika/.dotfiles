#!/bin/bash
#
# Manually installed: awcli aws-vault bat vim
#

if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y zsh zsh-common
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -Syu zsh
elif command -v brew >/dev/null 2>&1; then
  brew install zsh zsh-completions
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

mkdir -p ~/.oh-my-zsh/custom/plugins
mkdir -p ~/.oh-my-zsh/custom/themes

mkdir -p ~/.aws/cli

if command -v aws-vault >/dev/null 2>&1; then
  if [ -d ~/.oh-my-zsh/custom/plugins/zsh-aws-vault ]; then
    cd ~/.oh-my-zsh/custom/plugins/zsh-aws-vault && git pull
  else
    git clone https://github.com/blimmer/zsh-aws-vault.git ~/.oh-my-zsh/custom/plugins/zsh-aws-vault
  fi
fi

# Bye powerlevel9k, thank you!

#if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
#  cd ~/.oh-my-zsh/custom/themes/powerlevel9k && git pull
#else
#  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
#fi

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  cd ~/.oh-my-zsh/custom/themes/powerlevel10k && git pull
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if command -v bat >/dev/null 2>&1 && [ -d $(bat --config-dir) ]; then
  rm -rf /tmp/bat
  git clone git@github.com:catppuccin/bat.git /tmp/bat
  cd /tmp/bat/themes
  mkdir "$(bat --config-dir)/themes"
  cp *.tmTheme "$(bat --config-dir)/themes"
fi
