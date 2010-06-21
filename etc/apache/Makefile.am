

VHOSTS = www.$(AUTORG_DOMAIN)

CONF = apache.$(AUTORG_DOMAIN).conf

www.$(AUTORG_DOMAIN): www.in
	@cat "`echo ${@} | cut -d. -f1`.in" | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" \
		-e "s@%domain%@$(AUTORG_DOMAIN)@g"                  \
		> "`echo ${@}|cut -d. -f1`.$(AUTORG_DOMAIN)"
	@touch $(AUTORG_PATH)/triggers/apache_reload.do
	@echo "generated `echo ${@}|cut -d. -f1`.$(AUTORG_DOMAIN)"

apache.$(AUTORG_DOMAIN).conf: apache.conf.in
	@cat "`echo ${@} | cut -d. -f1`.conf.in" | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" \
		-e "s@%domain%@$(AUTORG_DOMAIN)@g"                  \
		> "`echo ${@}|cut -d. -f1`.$(AUTORG_DOMAIN).conf"
	@touch $(AUTORG_PATH)/triggers/apache_reload.do
	@echo "generated `echo ${@}|cut -d. -f1`.$(AUTORG_DOMAIN).conf"

all: $(VHOSTS) $(CONF)

install: all
	ln -sf "$(AUTORG_PATH)/etc/apache/*.$(AUTORG_DOMAIN)" /etc/apache2/sites-enabled

clean:
	rm -f $(VHOSTS) $(CONF)

dist-clean: clean
	rm -f Makefile Makefile.in test.pid


