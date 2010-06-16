SUBDIRS = etc src

# FIXME: use a timestamp for builds: -newer $buildstamp
ORG_FILES = $(shell find doc org -type f -name "*.org" -print 2>/dev/null)

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

all:
	@mkdir pub
	@if [ ! -r org ]; mkdir -m 0755 org; fi
	@emacs -batch -Q -l src/org-batch.el --eval='(autorg-publish-project "autorg" t)'

clean:
	@rm -rf pub
