# Simple Terminal+ (st+)

Simple Terminal+ is a lightweight terminal (~100KB) with essential features and rock-solid stability for daily use. It is best used with tmux and [nerd-fonts](https://github.com/ryanoasis/nerd-fonts). If you've always wanted to use st but dont want to bother with merging patches and coding features manually, then st+ is for you.

This is a fork of st from [suckless.org](https://st.suckless.org) for Gnome-based distros such as Debian/Ubuntu/Mint, but will work on all others as well. It is integrated with a minimal collection of essential patches along with other quality-of-life features:
- Basic configuration file in `~/.st.conf` (eg. changing font settings)
- Proper "Open Terminal Here" integration for Gnome's Nautilus:
  - Supports "Open in Remote/Local Terminal" for remote connections
- Scrollback (Shift+Mouse Scroll or Shift+PgUp/PgDn)
- Working directory (needed for "Open Terminal Here" integration)
- Desktop entry (for menu shortcuts)
- Alpha (transparent backgrounds)
- Blinking cursor (square box)
- One clipboard (better cut/paste)
- Fullscreen support (F11/Alt-Enter)
- Solarized dark theme
- Fira Code Nerd Fonts
- AppImage install (AM)


# Motivation

Modern terminals are just huge.

Here's an excerpt from the **xterm(1) README**:

> Abandon All Hope, Ye Who Enter Here

> This is undoubtedly the most ugly program in the distribution. It was one of the first "serious" programs ported, and still has a lot of historical baggage. Ideally, there would be a general tty widget and then vt102 and tek4014 subwidgets so that they could be used in other programs. We are trying to clean things up as we go, but there is still a lot of work to do.

It has over 65K lines of code and emulates obscure and obsolete terminals you will never need.

The popular alternative, rxvt has only 32K lines of code. This is just too much for something as simple as a terminal emulator; it's yet another example of code complexity.


# Installation (Manual Build)

You need the following packages:

    sudo apt install build-essential libxft-dev pkg-config python3-nautilus

To avoid conflicts, default nautilus open terminal extension should be removed:

    sudo apt remove nautilus-extension-gnome-terminal

To compile and install st+:

    git clone https://github.com/vishnu350/st
    cd st && make patch
    sudo make install
    fc-cache -fv

This installation method will also bundle and enable Fira Code Nerd fonts by default.


# Installation (AppImage)

Just download the latest AppImage from the release section. Rename it to **st+** and place it in your system PATH.

You must install the terminfo and manpages manually. Do this by running these commands from within st+ (create dirs if needed):

    sudo tic -sx $APPDIR/st.info
    sudo cp $APPDIR/st+.1 /usr/local/share/man/man1/.

This installation method will not include Fira Code Nerd fonts by default.


# Configuration

Configuration values such as font settings and alpha values will be stored in `~/.st.conf` for persistence, change this file if needed.

If this file does not exist or was deleted, it will be regenerated with safe defaults.


# Credits

- Patches merged from official suckless project page: https://st.suckless.org
- Open terminal python script adapted from Tilix: https://github.com/gnunn1/tilix
- Ivan's portable2appimage script: https://github.com/ivan-hc/portable2appimage
- Based on Aurélien APTEL <aurelien dot aptel at gmail dot com> bt source code.
