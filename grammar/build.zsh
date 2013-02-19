#!/bin/zsh

link=link-grammar-4.7.9
liblink=${link}/link-grammar/.libs/liblink-grammar.a

{ test "$1" = clean } && {
	pushd ${link}
	make clean
	popd
	rm -f grammar-filter/grammar-filter
	return 0
} 

{ test -r ${liblink} } || {
	pushd ${link}
	CC=clang CXX=clang++ ./configure --disable-java-bindings  \
	&& make
	popd
}

{ test -r grammar-filter/grammar-filter } || {
	pushd grammar-filter
	clang++ -O3 grammar.cc -I../${link} -I../${link}/link-grammar \
		../${link}/link-grammar/.libs/liblink-grammar.a -o grammar-filter
	popd
}
