#!/bin/sh
#
# autogen.sh -- Prepare the source tree for the configure script
#
# FIXME: check dependencies
# FIXME: license

autoreconf 2>/dev/null
automake -ac && autoreconf
