# st version
VERSION = 0.9.3-20
ARCH = $(shell uname -m)
STATIC ?= 0

# Customize below to fit your system
X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib
PKG_CONFIG = pkg-config

# includes and libs
INCS = -I$(X11INC) `$(PKG_CONFIG) --cflags x11 xft fontconfig freetype2`
ifeq ($(STATIC),0)
# Default dynamically linked library
LIBS = -lm -lutil `$(PKG_CONFIG) --libs x11 xft fontconfig freetype2`
else
# Customized library order for static linking (all except system libs), use st-build container
LIBS = -static-libgcc \
       -Wl,-Bstatic -lpng16 -lexpat -lz \
       -Wl,-Bdynamic -lm -lutil -lfreetype -lfontconfig -lX11 -lXft
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

# compiler and linker
# CC = c99
