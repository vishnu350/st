# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c sixel.c sixel_hls.c
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

imlib2:
	git submodule update --init
	cd imlib2 && ./autogen.sh with_x=no && make clean && make

clean:
	rm -rf st+ st+.1 $(OBJ) st*.tar.gz st-$(VERSION)* release st+-workdir.tmp *.orig *.rej config.h sixel*

dist: patch imlib2 st
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README.md config.mk\
		config.def.h st.info st.1 arg.h st.h win.h $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st+-$(VERSION).tar.gz
	rm -rf st-$(VERSION)
	mkdir -p release
	echo "Check GLIBC versions:"; objdump -T st+ | grep GLIBC | sort
	zip release/st+-$(VERSION)-$(ARCH)-static.zip st+
	./portable2appimage st+ st+ $(VERSION) "vishnu350|st|latest"
	mv st*.AppImage release/st+-$(VERSION)-$(ARCH).AppImage
	mv st*.AppImage.zsync release/st+-$(VERSION)-$(ARCH).AppImage.zsync
	mv st+-$(VERSION).tar.gz release/st+-$(VERSION)-source.tar.gz

install: patch st
	@./st-config install

uninstall:
	@./st-config uninstall

patch: clean
	mv patches patches.bak
	git checkout .
	rm -rf patches
	mv patches.bak patches
	$(foreach var, $(shell ls patches), printf "\nSource: $(var)\n"; patch -p1 --verbose < patches/$(var);)
	sed "s/VERSION/$(VERSION)/g" < st.1 > st+.1
ifndef STATIC
	sed -i 's/$$APPDIR\///g' x.c
endif
ifdef SYSICON
	sed -i 's/Icon=.*/Icon=utilities-terminal/' st+.desktop
endif

.PHONY: all clean dist install uninstall imlib2
