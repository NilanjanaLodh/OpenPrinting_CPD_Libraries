#                                               -*- Autoconf -*- 
# Process this file with autoconf to produce a configure script. 
 
AC_PREREQ([2.69]) 
AC_INIT([CPD-LIBRARY],[1.0],[nilanjanalodh@gmail.com]) 
AM_INIT_AUTOMAKE([-Wall foreign]) 
AC_CONFIG_SRCDIR([lib/frontend_helper.h]) 

# Check for a C compiler 
AC_PROG_CC 

#Check for archiver
AM_PROG_AR

LT_INIT

PKG_CHECK_MODULES([GIO],[gio-2.0]) 
PKG_CHECK_MODULES([GIOUNIX],[gio-unix-2.0]) 
PKG_CHECK_MODULES([GLIB],[glib-2.0]) 

# Checks for header files. 
AC_CHECK_HEADERS([stdlib.h string.h unistd.h cups/cups.h]) 
 
# Checks for typedefs, structures, and compiler characteristics. 
AC_TYPE_SIZE_T 
 
# Checks for library functions.
AC_FUNC_MALLOC
AC_CHECK_FUNCS([getcwd])

AC_CONFIG_FILES([Makefile
                 lib/Makefile
                 CPDBackend.pc
                 CPDFrontend.pc])

AC_OUTPUT