#!/usr/bin/env bash

if [ "$1" = "dev" ]; then
    cat vimrc.basic > ~/.vimrc

    echo "" >> ~/.vimrc
    cat vimrc.dev >> ~/.vimrc

    if [ -d ~/.vim ]; then
        cp -R vim/ ~/.vim/
    else
        cp -R vim ~/.vim
    fi
elif [ "$1" = "product" ]; then
    cat vimrc.basic > ~/.vimrc

    echo "" >> ~/.vimrc
    cat vimrc.product >> ~/.vimrc

    if [ -d ~/.vim ]; then
        cp -R vim/ ~/.vim/
    else
        cp -R vim ~/.vim
    fi
elif [ "$1" = "root" ]; then
    cat vimrc.basic > ~/.vimrc

    echo "" >> ~/.vimrc
    cat vimrc.root >> ~/.vimrc
fi

echo "" >> ~/.vimrc
echo "set termencoding=$2" >> ~/.vimrc
