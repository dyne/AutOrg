ELISPSCRIPTS  = $(shell ls -t *.el.in | sed 's/el.in/el/g')
SHELLSCRIPTS  = $(shell ls -t *.sh.in | sed 's/sh.in/sh/g')
# FIXME: use a timestamp for builds: -newer $buildstamp
ALL_ORG_FILES = $(shell find ../doc ../org -type f -name "*.org" -print 2>/dev/null)
EXPORT_PAGES  = $(echo $(ALL_ORG_FILES) | sed 's/.org/.html/g')
EXPORT_PAGES += $(echo $(ALL_ORG_FILES) | sed 's/.org/.pdf/g')
EXPORT_PAGES += $(echo $(ALL_ORG_FILES) | sed 's/.org/.txt/g')

mkscript = sed \
    -e "s|%autorg_path%|$(AUTORG_PATH)|g" \
    -e "s|%domain%|$(DOMAIN)|g" \
    -e "s|%orgmode_path%|$(ORGMODE)|g"

mkexport = emacs \
    -no-site-file -q -batch -l src/org-batch.el

%.html : %.org
	$(mkexport) --visit ${@/.*/.org} -f org-export-as-html > ${@/.*/.html}

%.pdf : %.org
	$(mkexport) --visit ${@/.*/.org} -f org-export-as-pdf  > ${@/.*/.pdf}

%.txt : %.org
	$(mkexport) --visit ${@/.*/.org} -f org-export-as-ascii > ${@/.*/.txt}

%.el : %.el.in
	$(mkscript) $@.in > $@

%.sh : %.sh.in
	$(mkscript) $@.in > $@
	@chmod +x $@

install:
	@mkdir -p /var/lock/autorg
	@chown www-data:www-data /var/lock/autorg
	@setfacl -m u:www-data:rw /var/lock/aurorg
	@echo "created /var/lock/autorg"

all: ${ELISPSCRIPTS} ${SHELLSCRIPTS} ${EXPORT_PAGES}

clean:
	rm -f *.html *.pdf *.txt *.tex ../pub/*.*
	rm -f *.el *.sh
	rm -f *~
