CONFS = org-batch.el

%.el : %.el.in
	@cat ${@}.in | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" \
			   -e "s@%domain%@$(DOMAIN)@g" \
			   -e "s@%orgmode_path%@$(ORGMODE)@g" > $@
	@echo "generated elisp for $@"

autorg.el: autorg.el.in

org-batch.el: org-batch.el.in

all: org-batch.el autorg.el

install:

clean:
	rm -f *.el
