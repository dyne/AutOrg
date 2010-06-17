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
	@echo "make [all]      -- Default: show this message and make all-pages"
	@echo "make all-pages  -- (Re-)Publish all pages from doc/ and org/"
	@echo "make new-pages  -- Publish new or updated pages from doc/ and org/"
	@echo "make doc        -- (Re-)Publish the HTML/PDF documentation from doc/"
	@echo "make pages      -- (Re-)Publish the HTML/PDF pages from org/"

	@echo

# FIXME: use awk-server, or check more dependencies such as a web server...
test: autorg-greeting
	@$(shell ./src/server.awk)
	@echo
	@echo " II AutOrg Web Server stopped."
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

all: targets all-pages

clean:
	@cd src && make clean
	@rm -rf pub
