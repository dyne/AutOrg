CONFS = org-batch.el

org-batch.el: org-batch.el.in
	@cat ${@}.in | sed -e "s@%autorg_path%@$(AUTORG_PATH)@" > $@
	@echo "generated elisp for $@"

autorg.el: autorg.el.in
	@cat ${@}.in | sed -e "s@%autorg_path%@$(AUTORG_PATH)@" \
		-e "s@%domain%@$(DOMAIN)@g" > $@

all: org-batch.el autorg.el

install:

clean:
	rm -f *.el
