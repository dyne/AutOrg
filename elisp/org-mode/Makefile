# Emacs options
EMACS    = emacs
SITEFLAG = --no-site-file

EL  = $(wildcard *.el)
ELC = $(patsubst %.el,%.elc, $(wildcard *.el))

all: $(ELC)

%.elc: %.el
	@$(EMACS) -no-site-file -q $(SITEFLAG) -batch -l ../org-batch.el \
		-f batch-byte-compile $<

clean:
	-rm -f *.elc *~


