ELISPSCRIPTS   = $(shell find . -type f -name "*.el.in" -print | sed 's/.el.in/.el/g')
SHELLSCRIPTS   = $(shell find . -type f -name "*.sh.in" -print | sed 's/.sh.in/.sh/g')
AUTORG_COMMAND = $(shell find . -type f -name "autorg*.in" -print | sed 's/.in//g')
 
mkscript = sed \
    -e "s|%autorg_path%|$(AUTORG_PATH)|g" \
    -e "s|%autorg_domain%|$(AUTORG_DOMAIN)|g" \
    -e "s|%orgmode_path%|$(ORGMODE_PATH)|g" \
    $1.in

autorg: autorg.in
	$(call mkscript,$@) > $@
	@chmod +x $@

autorg-%: autorg-%.in
	$(call mkscript,$@) > $@
	@chmod +x $@

%.el : %.el.in
	$(call mkscript,$@) > $@

%.sh : %.sh.in
	$(call mkscript,$@) > $@
	@chmod +x $@

all: ${ELISPSCRIPTS} ${SHELLSCRIPTS} ${AUTORG_COMMAND}

clean:
	rm -f *.el *.sh
	rm -f *~
