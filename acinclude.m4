dnl Copyright 2012 Mo McRoberts.
dnl
dnl  Licensed under the Apache License, Version 2.0 (the "License");
dnl  you may not use this file except in compliance with the License.
dnl  You may obtain a copy of the License at
dnl
dnl      http://www.apache.org/licenses/LICENSE-2.0
dnl
dnl  Unless required by applicable law or agreed to in writing, software
dnl  distributed under the License is distributed on an "AS IS" BASIS,
dnl  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
dnl  See the License for the specific language governing permissions and
dnl  limitations under the License.

m4_pattern_forbid([^UX_])dnl

AC_DEFUN([UX_BUILD_DOCS],[
AC_ARG_ENABLE([docs],[AS_HELP_STRING([--disable-docs],[disable re-building documentation (default=auto)])],[build_docs=$enableval],[build_docs=auto])
XML2MAN=true
XML2HTML=true
if test x"$build_docs" = x"yes" || test x"$build_docs" = x"auto" ; then
   AC_CHECK_PROGS([XSLTPROC],[xsltproc],[false])
   if test x"$XSLTPROC" = x"false" ; then
   	  if test x"$build_docs" = x"yes" ; then
	  	 AC_MSG_ERROR([re-building documentation was requested, but the xsltproc utility cannot be found])
	  fi
	  build_docs=no
   else
      build_docs=yes
	  XML2MAN='${XSLTPROC} -nonet \
		-param man.charmap.use.subset 0 \
		-param make.year.ranges 1 \
		-param make.single.year.ranges 1 \
		-param man.authors.section.enabled 0 \
		-param man.copyright.section.enabled 0 \
		http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl'
	  XML2HTML='${XSLTPROC} -nonet \
	    -param docbook.css.link 0 \
		-param generate.css.header 1 \
	    http://docbook.sourceforge.net/release/xsl-ns/current/xhtml5/docbook.xsl'
   fi
else
   build_docs=no
fi

AC_MSG_CHECKING([whether to re-build documentation if needed])
AC_MSG_RESULT([$build_docs])
AC_SUBST([XML2MAN])
AC_SUBST([XML2HTML])
])

AC_DEFUN([UX_ENABLE_NLS],[
AC_MSG_CHECKING([whether to enable native language support (NLS)])
AC_ARG_ENABLE([nls],[AS_HELP_STRING([--disable-nls],[disable native language support (NLS) (default=enabled)])],[build_nls=$enableval],[build_nls=yes])
AC_MSG_RESULT([$build_nls])
if test x"$build_nls" = x"yes" ; then
   AC_CHECK_HEADERS([locale.h nl_types.h])
   AC_CHECK_FUNC([setlocale],,[AC_MSG_ERROR([cannot locate the setlocale() function required for native language support (NLS)])])
   AC_CHECK_FUNC([catopen],,[AC_MSG_ERROR([cannot locate the catopen() function required for native language support (NLS)])])
   AC_CHECK_PROGS([GENCAT],[gencat],[false])
   if test x"$GENCAT" = x"false" ; then
   	  AC_MSG_ERROR([cannot locate the gencat utility required for native language support (NLS)])
   fi
   AC_DEFINE([ENABLE_NLS],[1],[Define if native language support (NLS) should be enabled])
   localedir=${libdir}/locale
fi
])
