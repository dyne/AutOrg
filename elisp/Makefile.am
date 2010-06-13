CONFS = org-batch.el muse-batch.el

org-batch.el: org-batch.el.in
	@cat ${@}.in | sed -e "s@%autorg_path%@$(AUTORG_PATH)@" > $@
	@echo "generated elisp for $@"

all: org-batch.el

install:

clean:
	rm -f *.el
