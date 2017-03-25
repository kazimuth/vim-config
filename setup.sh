#!/bin/sh

NEEDED=""

for COMMAND in "node npm python pip rustc cargo git curl vim"; do
    if [ -z "$(command -v $COMMAND)" ]; then
        NEEDED="$COMMAND $NEEDED"
    fi
done

if [ -n "$NEEDED" ]; then
    >&2 echo "Please install required commands: $NEEDED"
    exit 1
fi
pip install -U autopep8 jedi neovim
cargo install rustfmt
npm install -g js-beautify jshint tern neovim

curl -fLo ./autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

vim +PlugInstall

if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config
    ln -s "$(pwd)" ~/.config/nvim
fi
