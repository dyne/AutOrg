

VHOSTS = www.$(DOMAIN)

CONF = apache.$(DOMAIN).conf

www.$(DOMAIN): www.in
	@cat "`echo ${@} | cut -d. -f1`.in" | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" \
		-e "s@%domain%@$(DOMAIN)@g"                  \
		> "`echo ${@}|cut -d. -f1`.$(DOMAIN)"
	@touch $(AUTORG_PATH)/triggers/apache_reload.do
	@echo "generated `echo ${@}|cut -d. -f1`.$(DOMAIN)"

apache.$(DOMAIN).conf: apache.conf.in
	@cat "`echo ${@} | cut -d. -f1`.conf.in" | sed -e "s@%autorg_path%@$(AUTORG_PATH)@g" \
		-e "s@%domain%@$(DOMAIN)@g"                  \
		> "`echo ${@}|cut -d. -f1`.$(DOMAIN).conf"
	@touch $(AUTORG_PATH)/triggers/apache_reload.do
	@echo "generated `echo ${@}|cut -d. -f1`.$(DOMAIN).conf"

all: $(VHOSTS) $(CONF)

install: all
	ln -sf "$(AUTORG_PATH)/etc/apache/*.$(DOMAIN)" /etc/apache2/sites-enabled

clean:
	rm -f $(VHOSTS) $(CONF)

dist-clean: clean
	rm -f Makefile Makefile.in test.pid


