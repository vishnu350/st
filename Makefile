# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c
OBJ = $(SRC:.c=.o)
export arch = $(shell uname -m)
export version = $(shell grep "+VERSION" patches/st-vish.diff | awk '{print $$NF}')

all: st

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h

$(OBJ): config.h config.mk

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f st $(OBJ) st-$(VERSION).tar.gz

dist: clean
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h st.info st.1 arg.h st.h win.h $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st-$(VERSION).tar.gz
	rm -rf st-$(VERSION)

install: st
	cp -f open-terminal.py $(NAUTILUS_EXT)
	wget -c "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
	rm -rf $(DESTDIR)$(PREFIX)/share/fonts/FiraCodeNerd
	unzip FiraCode.zip -d $(DESTDIR)$(PREFIX)/share/fonts/FiraCodeNerd
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f st $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < st.1 > $(DESTDIR)$(MANPREFIX)/man1/st.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/st.1
	tic -sx st.info
	@echo Please see the README file regarding the terminfo entry of st.

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st.1
	rm -f $(NAUTILUS_EXT)/open-terminal.py
	rm -rf $(DESTDIR)$(PREFIX)/share/fonts/FiraCodeNerd

patch: clean
	mv patches patches.bak
	git checkout .
	rm -rf patches
	mv patches.bak patches
	rm -rf *.orig *.desktop *.rej config.h
	$(foreach var, $(shell ls patches), printf "\nSource: $(var)\n"; patch -p1 < patches/$(var);)

release: patch
	# Replace icon to avoid conflict, and set to default fonts (cant be packaged)
	sed -i 's/Icon=.*/Icon=st/' st.desktop
	sed -i 's/Fira Code Nerd Font:pixelsize=15/Liberation Mono:pixelsize=14/' config.def.h
	make st
	rm -rf release && mkdir -p release
	zip release/st-$(version)-$(arch)-static.zip st
	wget -c https://raw.githubusercontent.com/ivan-hc/portable2appimage/refs/heads/main/portable2appimage
	chmod +x portable2appimage
	./portable2appimage st st "vishnu350|st|latest"
	mv st*.AppImage release/st-$(version)-$(arch).AppImage
	mv st*.AppImage.zsync release/st-$(version)-$(arch).AppImage.zsync

.PHONY: all clean dist install uninstall
