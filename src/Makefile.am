ELISPSCRIPTS  = $(shell find . -type f -name "*.el.in" -print | sed 's/.el.in/.el/g')
SHELLSCRIPTS  = $(shell find . -type f -name "*.sh.in" -print | sed 's/.sh.in/.sh/g')

mkscript = sed \
    -e "s|%autorg_path%|$(AUTORG_PATH)|g" \
    -e "s|%domain%|$(DOMAIN)|g" \
    -e "s|%orgmode_path%|$(ORGMODE)|g" \
    $1.in

%.el : %.el.in
	$(call mkscript,$@) > $@

%.sh : %.sh.in
	$(call mkscript,$@) > $@
	@chmod +x $@

all: ${ELISPSCRIPTS} ${SHELLSCRIPTS}

clean:
	rm -f *.el *.sh
	rm -f *~
