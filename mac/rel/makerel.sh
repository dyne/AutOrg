#!/usr/bin/env zsh

{ test "$1" = "" } && {
	echo "usage: makerel.sh version"
	return 1 }

dir=AutOrg
ver=$1
out="`basename ${dir}`-${ver}.dmg"

echo "Making AutOrg release v$ver"

{ test -r ${dir} } || {
	echo "error: dir not found: $dir"
	return 0 }

{ test "$ver" = "" } && {
	echo "error: version not specified"
	return 0 }

# creating the directory and populating it
mkdir -p AutOrg
{ test -r ../AutOrg.app/Contents } && {
	echo "updating to latest app build"
	rm -rf AutOrg/AutOrg.app
	mv ../AutOrg.app ./AutOrg/
}
echo "Source app: `du -hs AutOrg/AutOrg.app`"
v=README; cp -f ../../${v} ./AutOrg/${v}.txt
v=COPYING; cp -f ../../${v} ./AutOrg/${v}.txt
v=AUTHORS; cp -f ../../${v} ./AutOrg/${v}.txt
v=ChangeLog; cp -f ../../${v} ./AutOrg/${v}.txt
v="Anonymous Pro.ttf"; cp ../../doc/${v} ./AutOrg/

echo "Generating release: $out"
echo "Source dir: `du -hs $dir`"
echo "proceed? (y|n)"
read -q ok
echo
{ test "$ok" = y } || {
	echo "operation aborted."
	return 0 }

hdiutil create -fs HFS+ -volname "$dir $ver" -srcfolder \
	${dir} "${out}"

{ test $? = 0 } || {
	echo "error creating image: ${out}"
	return 0 }

ls -lh ${out}

hdiutil internet-enable -yes ${out}

shasum ${out} > ${out}.sha

echo "sign release? (y|n)"
read -q ok
echo
{ test "$ok" = y } || {
	echo "done."
	return 1 }
gpg -b -a ${out}.sha
