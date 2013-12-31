#!/usr/bin/env zsh
# launch script for Ubuntu 12.04
# assuming org-mode is installed
# this script must be launched using full path

EMACS=emacs
AUTORG="`dirname $0 | sed 's/\/gnu$//'`"
TMP="/tmp/autorg"
mkdir -p $TMP

if [ "$AUTORG[1]" = "." ]; then
	echo "Error: this script must be launched specifiying its full path. I.e:"
	echo "  `pwd`/`basename $0`"
	echo "Or configuring a shell alias with:"
	echo "  alias autorg=`pwd`/`basename $0`"
	return 0
fi

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
	# check if there is X, else don't use custom fonts
	if [ "$DISPLAY" = "" ]; then
	  cat $HOME/.emacs | grep -v '^(set-face-font' >> $TMP/.emacs
	else
	  cat $HOME/.emacs >> $TMP/.emacs
	fi
fi

export PATH="$PATH:$AUTORG:$AUTORG/tools:/usr/texbin"
export GNUPGHOME="$HOME/.gnupg"
HOME=$TMP $EMACS $@
