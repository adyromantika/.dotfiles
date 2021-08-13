# .dotfiles

For my personal use, but it works for anyone. My tools and customizations might not be useful for everyone.

This readme is mainly for me to remember what I have to do in a brand new environment.

Should be idempotent. Common errors includes existing files i.e. ~/.vimrc and they aren't handled on purpose, so that I can examine existing files and decide whether to keep them.

## Install / Update

```shell
git checkout https://github.com/adyromantika/.dotfiles.git
cd .dotfiles
git submodule update --init
./install
```
