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
(add-to-list 'load-path "$appbase/$autorg")
(require 'autorg)
EOF

HOME=$appbase/$autorg $appbin/Emacs $@

