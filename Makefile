# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c
OBJ = $(SRC:.c=.o)

all: st

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h

$(OBJ): config.h config.mk

st: $(OBJ)
	$(CC) -o st+ $(OBJ) $(STLDFLAGS)
	strip st+

clean:
	rm -rf st+ st+.1 $(OBJ) st*.tar.gz st-$(VERSION)* release st+-workdir.tmp *.orig *.rej config.h

dist: clean
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README.md config.mk\
		config.def.h st.info st.1 arg.h st.h win.h $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st+-$(VERSION).tar.gz
	# Replace icon to avoid conflict, and set to default fonts
	sed -i 's/Icon=.*/Icon=st+/' st+.desktop
	sed -i 's/Fira Code Nerd Font:pixelsize=15/Liberation Mono:pixelsize=14/' config.def.h
	make st && mkdir -p release
	echo "Check GLIBC versions:"; objdump -T st+ | grep GLIBC | sort
	zip release/st+-$(VERSION)-$(ARCH)-static.zip st+
	./portable2appimage st+ st+ $(VERSION) "vishnu350|st|latest"
	mv st*.AppImage release/st+-$(VERSION)-$(ARCH).AppImage
	mv st*.AppImage.zsync release/st+-$(VERSION)-$(ARCH).AppImage.zsync
	mv st+-$(VERSION).tar.gz release/st+-$(VERSION)-source.tar.gz

install: st
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f st+ $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st+
	mkdir -p $(DESTDIR)$(APPPREFIX)
	cp -f st+.desktop $(DESTDIR)$(APPPREFIX)
	./post-install

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st+
	rm -f $(DESTDIR)$(APPPREFIX)/st+.desktop
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st+.1
	rm -f $(DESTDIR)$(NAUTILUS_EXT)/open-terminal.py

patch: clean
	mv patches patches.bak
	git checkout .
	rm -rf patches
	mv patches.bak patches
	$(foreach var, $(shell ls patches), printf "\nSource: $(var)\n"; patch -p1 < patches/$(var);)
	sed "s/VERSION/$(VERSION)/g" < st.1 > st+.1

.PHONY: all clean dist install uninstall
