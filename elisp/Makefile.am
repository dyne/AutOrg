CONFS = org-batch.el

%.el : %.el.in
	@cat ${@}.in | sed -e "s@%autorg_path%@$(AUTORG_PATH)@" \
			   -e "s@%domain%@$(DOMAIN)@g"> $@
	@echo "generated elisp for $@"

autorg.el: autorg.el.in

org-batch.el: org-batch.el.in

all: org-batch.el autorg.el

install:

clean:
	rm -f *.el
