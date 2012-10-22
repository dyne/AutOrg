#!/bin/sh

# AutOrg startup script for Mac .app
# Copyright (C) 2012 by Denis Roio <Jaromil@dyne.org>
# GNU GPL V3 (see COPYING)

appbin="${0%/*}"
appbase=$(dirname $(dirname $(dirname $appbin)))
autorg=AutOrg.app/Contents/Resources/AutOrg

cd $appbase

# check if our Inconsolata font is installed
# if ! [ -r $HOME/Library/Fonts/Inconsolata.otf ]; then
# if not, suggest that the user installs it

# generate the emacs initialization
rm -f $appbase/$autorg/.emacs
cat <<EOF > $appbase/$autorg/.emacs
(setq default-directory "$HOME" )
(setq AutOrgRes "$appbase/$autorg")
(add-to-list 'load-path AutOrgRes)
(require 'autorg)
(require 'osx)
EOF

export PATH=$PATH:/usr/texbin
HOME=$appbase/$autorg $appbin/Emacs $@

