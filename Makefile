DIR=$(shell pwd)
#these are the glib headers and libraries required by all the files
GLIB_FLAGS=$(shell pkg-config --cflags --libs gio-2.0 gio-unix-2.0 glib-2.0)
CUPS_FLAGS=$(shell cups-config --cflags --libs)

##Installation paths (Where to install the library??)
INSTALL_PATH?=/usr
##Libraries
LIB_INSTALL_PATH=$(INSTALL_PATH)/lib
HEADER_INSTALL_PATH=$(INSTALL_PATH)/include/cpd-interface-headers
PKGCONFIG_PATH=$(LIB_INSTALL_PATH)/pkgconfig

##The compiler and linker flags for making frontend clients
CPD_FRONT_FLAGS=$(shell pkg-config --cflags --libs CPDFrontend)


all: lib 
install: install-lib
test: print_frontend

#autogenerate the interface code from xml definition 
gen: src/backend_interface.c src/frontend_interface.c

src/frontend_interface.c:interface/org.openprinting.Frontend.xml
	gdbus-codegen --generate-c-code frontend_interface --interface-prefix org.openprinting interface/org.openprinting.Frontend.xml 
	mv frontend_interface.* src/

src/backend_interface.c:interface/org.openprinting.Backend.xml
	gdbus-codegen --generate-c-code backend_interface --interface-prefix org.openprinting interface/org.openprinting.Backend.xml 
	mv backend_interface.* src/

clean-gen:
	rm -f src/*_interface.*

src/frontend_helper.o:src/frontend_helper.c
	gcc -g -fPIC -c -o $@ $^ -I$(DIR)/src $(GLIB_FLAGS) $(CUPS_FLAGS)

src/%.o: src/%.c
	gcc -g -fPIC -c -o $@ $^ -I$(DIR)/src $(GLIB_FLAGS) 

#compile the libraries
lib: src/libCPDBackend.so src/libCPDFrontend.so

src/libCPDBackend.so: src/backend_interface.o src/frontend_interface.o src/common_helper.o
	gcc -shared -o $@ $^ $(GLIB_FLAGS)

src/libCPDFrontend.so: src/backend_interface.o src/frontend_interface.o src/common_helper.o src/frontend_helper.o 
	gcc -shared -o $@ $^ $(GLIB_FLAGS) $(CUPS_FLAGS)

#install the compiled libraries and their headers
install-lib: src/libCPDBackend.so src/libCPDFrontend.so
	mkdir -p $(LIB_INSTALL_PATH)
	cp src/*.so $(LIB_INSTALL_PATH)
	mkdir -p $(HEADER_INSTALL_PATH)
	cp src/*.h $(HEADER_INSTALL_PATH)
	mkdir -p $(PKGCONFIG_PATH)
	cp src/*.pc $(PKGCONFIG_PATH)

##compile the sample frontend
print_frontend: SampleFrontend/print_frontend.c 
	gcc -g -pg -o $@ $^ $(CPD_FRONT_FLAGS) $(GLIB_FLAGS)

clean:clean-gen
	rm -f src/*.so
	rm -f src/*.o 
	rm -f print_frontend

uninstall-lib:
	rm -f -r $(HEADER_INSTALL_PATH)
	rm -f $(LIB_INSTALL_PATH)/libCPDBackend.so
	rm -f $(LIB_INSTALL_PATH)/libCPDFrontend.so

release:
	@mkdir -p release/headers
	@mkdir -p release/libs
	cp src/*.h release/headers
	cp src/*.so release/libs