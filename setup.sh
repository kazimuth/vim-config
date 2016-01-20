#!/bin/sh

NEEDED=""

for COMMAND in "npm pip virtualenv rustc cargo git curl vim"; do
    if [ -z "$(command -v $COMMAND)" ]; then
        NEEDED="$COMMAND $NEEDED"
    fi
done

if [ -n "$NEEDED" ]; then
    >&2 echo "Please install required commands: $NEEDED"
    exit 1
fi

if [ ! -d ./env ]; then
    virtualenv ./env
    ./env/bin/pip2 install -r ./requirements.txt
fi


curl -fLo ./autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
vim +PlugInstall

cargo install rustfmt
npm install -g js-beautify jshint tern

if [ ! -d ~/.config/nvim ]; then
    mkdir -p ~/.config
    ln -s "$(pwd)" ~/.config/nvim
fi
