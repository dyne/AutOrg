confs = $(shell ls -t *.el.in | sed 's/el.in/el/g')

# scripts = $(shell ls -t *.sh.in | sed 's/sh.in/sh/g')

pages = $(shell ls -t *.org | sed 's/org/html/g')
pages += $(shell ls -t *.org | sed 's/org/pdf/g')
pages += $(shell ls -t *.org | sed 's/org/txt/g')


%.html : %.org
	emacs -no-site-file -q -batch \
		-l org-batch.el --visit `basename ${@} html`org \
		-f org-export-as-html

%.pdf : %.org
	emacs -no-site-file -q -batch \
		-l org-batch.el --visit `basename ${@} pdf`org \
		-f org-export-as-pdf

%.txt : %.org
	emacs -no-site-file -q -batch \
		-l org-batch.el --visit `basename ${@} txt`org \
		-f org-export-as-ascii

%.el : %.el.in
	@cat ${@}.in | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" \
			   -e "s@%domain%@$(DOMAIN)@g" \
			   -e "s@%orgmode_path%@$(ORGMODE)@g" > $@
	@echo "generated elisp for $@"

%.sh : %.sh.in
	@cat ${@}.in | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" > ${@}
	@chmod +x ${@}
	@echo "generated ${@}"

install:
	@mkdir -p /var/lock/autorg
	@chown www-data:www-data /var/lock/autorg
	@setfacl -m u:www-data:rw /var/lock/aurorg
	@echo "created /var/lock/autorg"


all: ${confs} ${scripts} ${pages}

clean:
	rm -f *.html *.pdf *.txt *.tex
	rm -f *.el *.sh
	rm -f *~
