# st version
VERSION = 0.9.3-5
ARCH = $(shell uname -m)
STATIC ?= 0

# Customize below to fit your system

# paths
PREFIX = /usr/local
APPPREFIX = $(PREFIX)/share/applications
MANPREFIX = $(PREFIX)/share/man

NAUTILUS_EXT = /usr/share/nautilus-python/extensions

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

PKG_CONFIG = pkg-config

# includes and libs
INCS = -I$(X11INC) \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
ifeq ($(STATIC),0)
# Default dynamically linked library
LIBS = -L$(X11LIB) -lm -lrt -lX11 -lutil -lXft \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2`
else
# Customized library order for static linking (all except system libs, eg. X11 and math)
LIBS = -Wl,-Bstatic  -lfontconfig -lfreetype -lpng16 -lbrotlidec -lbrotlicommon -lexpat -lz -lbz2 -lrt -lutil \
       -Wl,-Bdynamic -lm -lX11 -lXft
endif

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600
STCFLAGS = $(INCS) $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

# OpenBSD:
#CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
#LIBS = -L$(X11LIB) -lm -lX11 -lutil -lXft \
#       `$(PKG_CONFIG) --libs fontconfig` \
#       `$(PKG_CONFIG) --libs freetype2`
#MANPREFIX = ${PREFIX}/man

# compiler and linker
# CC = c99
