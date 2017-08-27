lib_LTLIBRARIES	= libCPDBackend.la libCPDFrontend.la
libCPDBackend_la_SOURCES = backend_interface.c frontend_interface.c common_helper.c
libCPDBackend_la_CPPFLAGS  = $(GLIB_CFLAGS)
libCPDBackend_la_CPPFLAGS += $(GIO_CFLAGS)
libCPDBackend_la_CPPFLAGS += $(GIOUNIX_CFLAGS)

libCPDBackend_la_LIBADD  = $(GLIB_LIBS)
libCPDBackend_la_LIBADD += $(GIO_LIBS)
libCPDBackend_la_LIBADD += $(GIOUNIX_LIBS)

libCPDFrontend_la_SOURCES = backend_interface.c frontend_interface.c \
                            common_helper.c frontend_helper.c
libCPDFrontend_la_CPPFLAGS  = $(GLIB_CFLAGS)
libCPDFrontend_la_CPPFLAGS += $(GIO_CFLAGS)
libCPDFrontend_la_CPPFLAGS += $(GIOUNIX_CFLAGS)

libCPDFrontend_la_LIBADD  = -lcups -lpthread -lm -lcrypt
libCPDFrontend_la_LIBADD += $(GLIB_LIBS)
libCPDFrontend_la_LIBADD += $(GIO_LIBS)
libCPDFrontend_la_LIBADD += $(GIOUNIX_LIBS)

##INSTALL HEADERS
cpd_interface_headersdir = $(includedir)/cpd-interface-headers
cpd_interface_headers_HEADERS = backend_interface.h \
                                frontend_interface.h \
                                common_helper.h \
                                frontend_helper.h 

include_HEADERS = CPDBackend.h CPDFrontend.h 

backend_interface.c backend_interface.h: interface/org.openprinting.Backend.xml
	$(AM_V_GEN)gdbus-codegen --generate-c-code backend_interface \
    --interface-prefix org.openprinting \
    interface/org.openprinting.Backend.xml 

frontend_interface.c frontend_interface.h: interface/org.openprinting.Frontend.xml
	$(AM_V_GEN)gdbus-codegen --generate-c-code frontend_interface \
    --interface-prefix org.openprinting \
    interface/org.openprinting.Frontend.xml

genfiles = *_interface.*

clean-local:
	rm -f $(genfiles) 