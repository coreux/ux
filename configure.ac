## Copyright 2012 Mo McRoberts.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.

AC_INIT([ux],[master])

AM_INIT_AUTOMAKE([foreign])
AM_MAINTAINER_MODE

dnl - UX_PROJECT([var],[group],[project])
dnl As AC_CONFIG_SUBDIRS, but looks for group/project and adds
dnl 'project' to $var
AC_DEFUN([UX_PROJECT],[
if test -d "$srcdir/[$2]/[$3]" ; then
   [$1]="$[$1] [$3]"
   AC_CONFIG_SUBDIRS([$2]/[$3])
fi
])

bin_subdirs=''
UX_PROJECT([bin_subdirs],[bin],[echo])
UX_PROJECT([bin_subdirs],[bin],[false])
UX_PROJECT([bin_subdirs],[bin],[link])
UX_PROJECT([bin_subdirs],[bin],[mesg])
UX_PROJECT([bin_subdirs],[bin],[true])
UX_PROJECT([bin_subdirs],[bin],[uname])
UX_PROJECT([bin_subdirs],[bin],[unlink])
AC_SUBST([bin_subdirs])

AC_CONFIG_FILES([
Makefile
bin/Makefile
])

AC_OUTPUT
