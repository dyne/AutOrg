#!/bin/sh

# AutOrg startup script for Mac .app
# Copyright (C) 2012-2013 by Denis Roio <Jaromil@dyne.org>
# GNU GPL V3 (see COPYING)

appbin="${0%/*}"
# appbase is the directory containing AutOrg.app
# most commonly this will be /Applications
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
# honor user's configuration
if [ -r $HOME/.emacs ]; then
	cat $HOME/.emacs >> $appbase/$autorg/.emacs
fi

export
PATH="$PATH:$appbase/$autorg:/usr/texbin:/usr/local/bin:/opt/local/bin:/Applications/LibreOffice.app/Contents/MacOS"
export GNUPGHOME="$HOME/.gnupg"
# export LANG=en_US
# export LC_CTYPE=UTF-8
cat <<EOF > $appbase/$autorg/.aspell.conf
dict-dir $appbase/$autorg/dict
data-dir $appbase/$autorg/dict
#add-extra-dicts en
#add-extra-dicts grc
home-dir $HOME
EOF
HOME=$appbase/$autorg $appbin/Emacs $@

