#!/bin/sh
#
# Copyright 2010 Denis Roio <jaromil@dyne.org>
#
# This source code is free software; you can redistribute it and/or
# modify it under the terms of the GNU Public License as published 
# by the Free Software Foundation; either version 2 of the License,
# or (at your option) any later version.
#
# This source code is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# Please refer to the GNU Public License for more details.
#
# You should have received a copy of the GNU Public License along with
# this source code; if not, write to:
# Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA

# small shell script to compile .org pages into html, pdf and txt
# using emacs, with configs and templates from dyne-web repo
# note the templating done by a 'sed' command in Makefule
# /home/jaromil/web/autorg is filled with a PATH value obtained by configure.ac

if [ "$1" = "-h" ]; then
    echo "usage: org-compile-pages.sh [file.org]"
    exit 1
fi

autorg=/home/jaromil/web/autorg

if [ -z $1 ]; then # no file specified, make all *.org in current dir
    
    for f in `ls *.org`; do
	
	emacs -no-site-file -q -batch \
	    -l ${autorg}/elisp/org-batch.el --visit $f \
	    -f org-export-as-ascii 

	emacs -no-site-file -q -batch \
	    -l ${autorg}/elisp/org-batch.el --visit $f \
	    -f org-export-as-html

	emacs -no-site-file -q -batch \
	    -l ${autorg}/elisp/org-batch.el --visit $f \
	    -f org-export-as-pdf
	
	
    done

else

    emacs -no-site-file -q -batch \
	-l ${autorg}/elisp/org-batch.el --visit $1 \
	-f org-export-as-ascii

    emacs -no-site-file -q -batch \
	-l ${autorg}/elisp/org-batch.el --visit $1 \
	-f org-export-as-html

    emacs -no-site-file -q -batch \
	-l ${autorg}/elisp/org-batch.el --visit $1 \
	-f org-export-as-pdf
    
    
fi
