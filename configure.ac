dnl ==============================================================
dnl Process this file with autoconf to produce a configure script.
dnl ==============================================================

dnl require autoconf 2.62 (AS_ECHO/AS_ECHO_N)
AC_PREREQ([2.60])

AC_INIT([autorg],[html5],[hackers@dyne.org],[dyne.org])
AC_CONFIG_MACRO_DIR([m4])

AC_CANONICAL_HOST

dnl backwards compatibility for autoconf >= 2.64
dnl PACKAGE_URL should be the fifth argument of AC_INIT
m4_define([AC_PACKAGE_URL], [http://autorg.dyne.org])
AC_DEFINE(PACKAGE_URL, "AC_PACKAGE_URL", [Package URL])
AC_SUBST(PACKAGE_URL, AC_PACKAGE_URL)

dnl ==============================================================
dnl Get the operating system and version number...
dnl ==============================================================
AC_MSG_CHECKING([for which platform we are setting up])

case "$host_os" in
  *linux*)
    AC_MSG_RESULT([Linux])
    have_linux=yes

    if test x$have_x86_64 = xyes; then
        have_64bit=yes
    fi

    if test x$have_x86_32 = xyes; then
        have_32bit=yes
    fi
  ;;

  *darwin*)
    AC_MSG_RESULT([Darwin/OSX])
    have_darwin=yes
  ;;

  *freebsd*)
    AC_MSG_RESULT([FreeBSD])
    have_freebsd=yes
  ;;

  *)
    AC_MSG_RESULT([$host_os?!])
    AC_MSG_ERROR([[
[!] Your system architecture is not supported by the dyne.org website
]], 0)
  ;;
esac


dnl ==============================================================
dnl Setup for automake
dnl ==============================================================

AM_INIT_AUTOMAKE([dist-bzip2 subdir-objects -Wno-portability])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_CONFIG_SRCDIR([doc/autonomy-is-organization.org])

dnl Checks for programs.
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET

dnl compatibility with older libtool
dnl m4_ifndef([LT_INIT], [AC_PROG_RANLIB])


dnl versioning info for libtool
DYNE_CURRENT=0
DYNE_REVISION=0
DYNE_AGE=0
DYNE_VERSION_INFO="$DYNE_CURRENT:$DYNE_REVISION:$DYNE_AGE"
dnl Note this is the ABI version which is not the same as our actual
dnl library version
AC_SUBST(DYNE_VERSION_INFO)


dnl ###########################################################################
dnl ###### now about compile time paths
AC_MSG_CHECKING([which installation prefix to use])
if test "x${prefix}" = "xNONE"; then
   prefix=`pwd`
fi
AC_MSG_RESULT([${prefix}])
AUTORG_PATH="${prefix}"
AC_SUBST(AUTORG_PATH)

AC_MSG_CHECKING([for which domain we are configuring])
AC_ARG_WITH(domain,
	    AS_HELP_STRING([--with-domain],[specify a network domain: dyne.org or us.dyne.org (default local.org)]),
	    [with_domain=$withval],
	    [with_domain=local.org])
AC_MSG_RESULT([${with_domain}])
DOMAIN="$with_domain"
AC_SUBST(DOMAIN)

AC_MSG_CHECKING([which org-mode to use])
AC_ARG_WITH(org-mode,
	AS_HELP_STRING([--with-org-mode],[specify where to find org-mode]),
	[with_orgmode=$withval],
	[with_orgmode=auto])
AC_MSG_RESULT([${with_orgmode}])
ORGMODE="$with_orgmode"
AC_SUBST(ORGMODE)

dnl alphabetic order on dir/subdir, but Makefile sorts before everything
AC_CONFIG_FILES([
Makefile
etc/Makefile
etc/apache/Makefile
doc/Makefile
src/Makefile
])

AC_OUTPUT


dnl autoconf < 2.63 compatibility
m4_ifndef([AS_VAR_APPEND],
          AC_DEFUN([AS_VAR_APPEND], $1=$$1$2))

dnl convenience function so that INFO messages go to config.log and to stdout,
dnl useful when debugging user problems only config.log is needed

dnl as above, but no newline at the end

echo
echo
echo "Compile $PACKAGE $VERSION for ${host}"
echo "configuration summary, pass V=1 to configure for verbose output"

echo "============================== now type make, may the source be with you!"

# vim:et:ts=3:sw=3
