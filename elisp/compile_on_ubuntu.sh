#!/bin/zsh
# elisp compiles all files in autorg

AUTORG="`dirname $0 | sed 's/\/elisp$//'`"
TMP="/tmp/autorg"
mkdir -p $TMP

files=()
for i in `find . -name '*.el'`; do files+=($i); done

cat <<EOF > $TMP/.emacs
(setq default-directory "$HOME" )
(setq AutOrgRes "$AUTORG/elisp")
(add-to-list 'load-path AutOrgRes)
(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/23/lisp/")
(require 'autorg)
EOF
# EMACSLOADPATH=/usr/share/emacs/site-lisp:/usr/share/emacs/23.4/lisp/:/home/jrml/devel/autorg/elisp/:/home/jrml/devel/autorg/elisp/org-mode/lisp \
HOME=$TMP emacs \
 --debug-init --batch  -f batch-byte-compile $files
