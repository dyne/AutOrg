SUBDIRS = awk elisp manual

EXTRA_DIST = config.in

all:
	sed -e 's@\%datadir\%@'"$(datadir)"'@' $(top_srcdir)/share/config.in > \
					      $(top_builddir)/share/config

install: all
	install -m 0644 -D config /etc/autorg/config