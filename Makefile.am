SUBDIRS = etc src

ORG_FILES = $(shell find doc org -type f -name "*.org" -print 2>/dev/null)

autorg_publish = emacs -batch -Q -l src/org-batch.el \
                 --eval='(org-publish-batch-project "$1" $2)'

autorg-dirs:
	@mkdir -p org pub

autorg-greeting:
	@echo
	@echo ".:| AutOrg v$(shell cat VERSION) == Distributed, Autonomous Information System |:."
	@echo

targets: autorg-greeting
	@echo "make            -- Default: show this message and make new-pages"
	@echo "make all-pages  -- (Re-)Publish all pages from doc/ and org/"
	@echo "make new-pages  -- Publish new or updated pages from doc/ and org/"
	@echo "make doc        -- (Re-)Publish the HTML/PDF documentation from doc/"
	@echo "make pages      -- (Re-)Publish the HTML/PDF pages from org/"

	@echo

# FIXME: use awk-server, or check more dependencies such as a web server...
test: autorg-greeting
	@echo "starting an minimal apache server to test (requires root)"
	@echo "make sure your /etc/hosts is configured accordingly"
	@echo "sudo sh -c 'echo \"127.0.0.1 autorg.$(DOMAIN)\" >> /etc/hosts'"
	@echo
	sudo mkdir -p /var/run/apache2 log/
	sudo apache2 -f etc/apache/apache.$(DOMAIN).conf
	@sleep 1
	@echo
	@echo "apache2 running with pid `cat etc/apache/test.pid`"
	@echo "to stop it, use 'sudo killall apache2' or simply:"
	@echo "sudo kill `cat etc/apache/test.pid`"
	@echo

doc: autorg-greeting autorg-dirs
	@echo " II Exporting AutOrg Documentation to pub/doc/"
	@echo
	@$(call autorg_publish,autorg-docs,t)
	@echo

pages: autorg-greeting autorg-dirs
	@echo " II Exporting AutOrg Pages to pub/"
	@echo
	@$(call autorg_publish,autorg-pages,t)
	@echo

all-pages: doc pages

new-pages: autorg-greeting autorg-dirs
	@echo " II Updating AutOrg pages"
	@echo
	@$(call autorg_publish,autorg,)
	@echo

all: targets new-pages

clean:
	@cd src && make clean
	@rm -rf pub
