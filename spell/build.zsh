#!/bin/zsh

aspell=aspell-0.60.6.1

pushd ${aspell}
CC=clang CXX=clang++ ./configure --enable-static --disable-shared --disable-curses 
make
popd
cp ${aspell}/aspell .
