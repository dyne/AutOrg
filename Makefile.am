SUBDIRS = etc src

# FIXME: use automake settings
docdir=doc
orgdir=org
srcdir=src
builddir=pub

# FIXME: use a timestamp for builds: -newer $buildstamp
ALL_ORG_FILES = $(shell find $docdir $orgdir -type f -name "*.org" -print 2>/dev/null)
EXPORT_PAGES  = $(echo $(ALL_ORG_FILES) | sed 's/.org/.html/g')
EXPORT_PAGES += $(echo $(ALL_ORG_FILES) | sed 's/.org/.pdf/g')
EXPORT_PAGES += $(echo $(ALL_ORG_FILES) | sed 's/.org/.txt/g')

mkexport = emacs \
    -no-site-file -q -batch -l $(srcdir)/org-batch.el \
    --visit ${2/.*/.org} -f org-export-as-$1

%.html : %.org
	$(call mkexport,html,$@) > $(builddir)/$(basename ${@/.*/.html})

%.pdf : %.org
	$(call mkexport,pdf,$@)  > $(builddir)/$(basename ${@/.*/.pdf})

%.txt : %.org
	$(call mkexport,ascii,$@) > $(builddir)/$(basename ${@/.*/.txt})

# FIXME: use awk-server, or check more dependencies such as a web server...
test:
	@echo
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

all: ${EXPORT_PAGES}

clean:
	rm -f $(builddir)/*.*
