#Customisable stuff here
WIN32_COMPILER = cc
WIN32_WINDRES = windres
CFLAGS = $(shell pkg-config --cflags gtk+-2.0 glib-2.0 pidgin purple) -DPURPLE_PLUGINS -DENABLE_NLS -DHAVE_ZLIB
LIBS = $(shell pkg-config --libs gtk+-2.0 glib-2.0 pidgin purple) -lgdi32 -ldwmapi

all:	pidgin-win7.dll

clean:
	rm -f pidgin-win7.dll

pidgin-win7.res:	pidgin-win7.rc
	${WIN32_WINDRES} -i $< -O coff -o $@

pidgin-win7.dll:	pidgin-win7.c pidgin-win7.h pidgin-win7.res
	${WIN32_COMPILER} ${CFLAGS} -Wall -I. -O2 -pipe $< pidgin-win7.res -o $@ -shared ${CFLAGS} ${LIBS} -Wl,--strip-all -mms-bitfields -Wl,--enable-auto-image-base
#	upx $@

pidgin-win7-debug.dll:	pidgin-win7.c pidgin-win7.h pidgin-win7.res
	${WIN32_COMPILER} ${CFLAGS} -Wall -I. -g -O2 -pipe $< pidgin-win7.res -o $@ -shared ${CFLAGS} ${LIBS} -mms-bitfields -Wl,--enable-auto-image-base

