
mklistscripts = $(shell find . -type f -name "*.$1.in" -print | sed 's/.in//g')

AWKSCRIPTS   = $(call mklistscripts,awk)
ELISPSCRIPTS = $(call mklistscripts,el)
SHELLSCRIPTS = $(call mklistscripts,sh)

mkscript = sed \
    -e "s|%autorg_path%|$(AUTORG_PATH)|g" \
    -e "s|%domain%|$(DOMAIN)|g" \
    -e "s|%orgmode_path%|$(ORGMODE)|g" \
    $1.in 2>/dev/null

%.awk: %.awk.in
	@$(call mkscript,$@) > $@
	@chmod +x $@

%.el : %.el.in
	@$(call mkscript,$@) > $@

%.sh : %.sh.in
	@$(call mkscript,$@) > $@
	@chmod +x $@

all: ${AWKSCRIPTS} ${ELISPSCRIPTS} ${SHELLSCRIPTS}
	@mkdir -p ../pub/
	@cp favicon.ico ../pub

clean:
	@rm -f *.awk *.el *.sh
	@rm -f *~
