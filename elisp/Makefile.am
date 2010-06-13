CONFS = org-batch.el muse-batch.el

org-batch.el: org-batch.el.in
	@cat ${@}.in | sed -e "s@%dyne_path%@$(DYNE_PATH)@" > $@
	@echo "generated elisp for $@"

muse-batch.el: muse-batch.el.in
	@cat ${@}.in | sed -e "s@%dyne_path%@$(DYNE_PATH)@" > $@
	@echo "generated elisp for $@"

all: org-batch.el muse-batch.el

install:

clean:
	rm -f *.el
