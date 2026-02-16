#!/bin/bash

rm -rf /tmp/bat
git clone git@github.com:catppuccin/bat.git /tmp/bat
mkdir -p "$(bat --config-dir)/themes"
cp /tmp/bat/themes/*.tmTheme "$(bat --config-dir)/themes"
bat cache --build
rm -rf /tmp/bat
