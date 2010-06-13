
SHELLSCRIPTS = 	org-compile-pages.sh

$(SHELLSCRIPTS):
	@cat "`basename ${@} sh`in" | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" > ${@}
	@chmod +x ${@}
	@echo "generated ${@}"

all: $(SHELLSCRIPTS)

install:
	@mkdir -p /var/lock/autorg
	@chown www-data:www-data /var/lock/autorg
	@setfacl -m u:www-data:rw /var/lock/aurorg
	@echo "created /var/lock/autorg"

clean:
	rm $(SHELLSCRIPTS)
