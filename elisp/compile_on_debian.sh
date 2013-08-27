#!/bin/zsh

files=()
for i in `find . -name '*.el'`; do
#	grep 'color-theme' $i > /dev/null
#	{ test $? = 0 } && { continue }
	files+=($i)
done

# EMACSLOADPATH=/usr/share/emacs/site-lisp:/usr/share/emacs/23.4/lisp/:/home/jrml/devel/autorg/elisp/:/home/jrml/devel/autorg/elisp/org-mode/lisp \
EMACSLOADPATH=/usr/share/emacs/site-lisp:/usr/share/emacs/23.4/lisp/:/home/jrml/devel/autorg/elisp/:/home/jrml/devel/autorg/elisp/org-mode/lisp \
  emacs --debug-init --batch  -f batch-byte-compile $files
