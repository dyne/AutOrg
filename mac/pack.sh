#!/bin/sh

# Transform an Emacs.app into AutOrg

# to make a new dmg prepare a dir with link to /Applications and
# the toasted AutOrg.app inside, adjust its visualization then use:
# hdiutil create AutOrg-0.2.dmg -ov -volname "AutOrg-0.2" -fs HFS+ -srcfolder dist

echo "Packing AutOrg.app"

if [ -r AutOrg.app ]; then
	echo "Using already packaged AutOrg.app in this directory"
elif [ -r /Applications/Emacs.app ]; then
	echo "Using Emacs.app found in Applications"
	mkdir -p AutOrg.app
	rsync -a /Applications/Emacs.app/* AutOrg.app/
elif [ -r /Applications/AutOrg.app ]; then
	echo "Using AutOrg.app found in Applications"
	mkdir -p AutOrg.app
	rsync -a /Applications/AutOrg.app/* AutOrg.app/
else
	echo "Emacs.app or AutOrg.app starting base not found on system"
	exit 1
fi

# make sure we use our own org-mode
if [ -r AutOrg.app/Contents/Resources/lisp/org ]; then
	rm -rf AutOrg.app/Contents/Resources/lisp/org
fi
cp -f Info.plist AutOrg.app/Contents/
cp -f AutOrg.command AutOrg.app/Contents/MacOS
cp -f AutOrg.icns AutOrg.app/Contents/Resources/
mkdir -p AutOrg.app/Contents/Resources/AutOrg
rsync -a ../elisp/* AutOrg.app/Contents/Resources/AutOrg/

# grammar parser
rsync -r ../grammar/data/en AutOrg.app/Contents/Resources/AutOrg/
cp ../grammar/grammar-filter/grammar-filter AutOrg.app/Contents/Resources/AutOrg/

# aspell
cp ../spell/aspell AutOrg.app/Contents/Resources/AutOrg/
cp ../spell/ispell AutOrg.app/Contents/Resources/AutOrg/
# cp ../spell/dictionaries.el AutOrg.app/Contents/Resources/AutOrg/
rsync -ra ../spell/dict AutOrg.app/Contents/Resources/AutOrg/

# GnuPG for EPA encryption (provided by brew)
if [ -r AutOrg.app/Contents/Resources/AutOrg/gpg ]; then
  chmod +w AutOrg.app/Contents/Resources/AutOrg/gpg; fi
cp /usr/local/bin/gpg AutOrg.app/Contents/Resources/AutOrg/

echo "Done."
