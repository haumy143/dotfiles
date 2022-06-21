#!/bin/bash

ZSHRC=

sudo apt update
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp .zshrc ~/.zshrc
cp pygmalion.zsh-theme ~/.oh-my-zsh/themes/pygmalion.zsh-theme
. ~/.zshrc
