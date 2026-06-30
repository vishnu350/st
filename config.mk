# st version
VERSION = 0.9.3-26
ARCH = $(shell uname -m)

# Customize below to fit your system
X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib
PKG_CONFIG = pkg-config

# includes and libs
INCS = -I$(X11INC) `$(PKG_CONFIG) --cflags x11 xft fontconfig freetype2`
ifndef STATIC
# Default dynamically linked library
LIBS = -lm -lutil `$(PKG_CONFIG) --libs x11 xft fontconfig freetype2 imlib2`
else
# Customized library order for static linking (all except system libs), use st-build container
LIBS = -static-libgcc \
       -Wl,-Bstatic -lpng16 -lexpat -lz ./imlib2/src/lib/.libs/libImlib2.a \
       -Wl,-Bdynamic -lm -ldl -lutil -lfreetype -lfontconfig -lX11 -lXft
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
