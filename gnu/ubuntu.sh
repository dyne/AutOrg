#!/bin/sh
# launch script for Ubuntu 12.04
# assuming org-mode is installed

EMACS=emacs
AUTORG="`dirname $0 | sed 's/\/gnu$//'`"
TMP="/tmp/autorg"
mkdir -p $TMP

echo "Starting autorg in $AUTORG"
# generate the emacs initialization
rm -f $TMP/.emacs
cat <<EOF > $TMP/.emacs
(setq default-directory "$HOME" )
(setq AutOrgRes "$AUTORG/elisp")
(add-to-list 'load-path AutOrgRes)
(require 'autorg)
EOF

# honor user's configuration
if [ -r $HOME/.emacs ]; then
	cat $HOME/.emacs >> $TMP/.emacs
fi


export PATH="$PATH:$AUTORG:/usr/texbin"
export GNUPGHOME="$HOME/.gnupg"
# export LANG=en_US
# export LC_CTYPE=UTF-8
cat <<EOF > $AUTORG/.aspell.conf
dict-dir $AUTORG/dict
data-dir $AUTORG/dict
#add-extra-dicts en
#add-extra-dicts grc
home-dir $HOME
EOF
HOME=$TMP $EMACS $@
