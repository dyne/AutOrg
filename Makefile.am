SUBDIRS = etc src

ORG_FILES = $(shell find doc org -type f -name "*.org" -print 2>/dev/null)

autorg_publish = emacs -batch -Q -l src/org-batch.el \
                 --eval='(org-publish-batch-project "$1" $2)'

autorg-dirs:
	@mkdir -p org pub
	@cp src/favicon.ico pub/

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
	@echo "make preview    -- Locally serve pages on http://localhost:8080/"
	@echo

# FIXME: use awk-server, or check more dependencies such as a web server...
preview: autorg-greeting
	@echo "starting an minimal http server (awk) on port 8080 - hit Ctrl-C to quit"
	@cd pub && ../src/server.awk -v docroot=`pwd`

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
