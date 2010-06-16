ELISPSCRIPTS  = $(shell ls -t *.el.in | sed 's/el.in/el/g')
SHELLSCRIPTS  = $(shell ls -t *.sh.in | sed 's/sh.in/sh/g')
EXPORT_PAGES  = $(shell ls -t *.org | sed 's/org/html/g')
EXPORT_PAGES += $(shell ls -t *.org | sed 's/org/pdf/g')
EXPORT_PAGES += $(shell ls -t *.org | sed 's/org/txt/g')

mkscript = sed \
    -e "s|%autorg_path%|$(AUTORG_PATH)|g" \
    -e "s|%domain%|$(DOMAIN)|g" \
    -e "s|%orgmode_path%|$(ORGMODE)|g"

%.html : %.org
	./org-export-as.sh html ${@}

%.pdf : %.org
	./org-export-as.sh pdf ${@}

%.txt : %.org
	./org-export-as.sh ascii ${@}

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

pages:
	./org-compile-pages.sh
	cp *.html *.pdf *.tex *.txt ../pub
	@echo "Exported updated pages"

all: ${ELISPSCRIPTS} ${SHELLSCRIPTS} ${EXPORT_PAGES}

clean:
	rm -f *.html *.pdf *.txt *.tex ../pub/*.*
	rm -f *.el *.sh
	rm -f *~

