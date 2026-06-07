# Simple Terminal+ (st+)

<img src="https://github.com/user-attachments/assets/14914cf1-5bfb-4f2f-859e-5d15da46ade0" alt="drawing" width="50%"/>

Simple Terminal+ is a lightweight terminal (~100KB) with essential features and rock-solid stability for daily use. It is best used with tmux and [nerd-fonts](https://www.nerdfonts.com/). If you just want a minimal, solarized, simple terminal that supports all of the mentioned features, then st+ is for you.

This is a fork of st from [suckless.org](https://st.suckless.org) for Gnome-based distros such as Debian/Ubuntu/Mint, but will work on all others as well. It is integrated with a minimal collection of essential patches along with other quality-of-life features:
- Automatically install a [nerd-font](https://www.nerdfonts.com/) via the `st-config` script.
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
- AppImage install (AM)


# Motivation

Modern terminals are just huge.

Here's an excerpt from the **xterm(1) README**:

> Abandon All Hope, Ye Who Enter Here

> This is undoubtedly the most ugly program in the distribution. It was one of the first "serious" programs ported, and still has a lot of historical baggage. Ideally, there would be a general tty widget and then vt102 and tek4014 subwidgets so that they could be used in other programs. We are trying to clean things up as we go, but there is still a lot of work to do.

It has over 65K lines of code and emulates obscure and obsolete terminals you will never need.

The popular alternative, rxvt has only 32K lines of code. This is just too much for something as simple as a terminal emulator; it's yet another example of code complexity.


# Installation (AppImage)

The recommended AppImage installation method is through Ivan's [AM/Appman](https://github.com/ivan-hc/AM):

    am -i st+

Or just download it from the [release section](https://github.com/vishnu350/st/releases), rename it to **st+** and place it in your system PATH.

Next, run the st install script from within st+ (needs root):

    $APPDIR/st-config

This will download a nerd-font of your choice and setup the terminfo/manpage/nautilus script. This script can be run multiple times to download additional fonts, if you wish to do so.

Notes on AppImage install flow:
- [AM/Appman](https://github.com/ivan-hc/AM) supports auto-updates with checksum integrity verification.
- AppImages will be larger in size, but there will be virtually zero difference in performance.
- To download/configure more fonts, just rerun the st-config script: `$APPDIR/st-config`
- To remove st+ from your system, just run the st-config script with the uninstall switch: `$APPDIR/st-config uninstall`


# Installation (Manual Build)

You will need the following packages:

    sudo apt install build-essential libxft-dev pkg-config wget python3-nautilus

To avoid conflicts, the default nautilus open terminal extension should be removed if installed:

    sudo apt remove nautilus-extension-gnome-terminal

To compile and install st+ (needs root):

    git clone https://github.com/vishnu350/st
    cd st && make patch
    make install

**Only for devs**: To build static binaries for distribution/release, run the following command from within an old container (st-build.dockerfile):

    make dist STATIC=1

Notes on manual install flow:
- No auto-updates.
- Compiled binary size will be tiny (~100KB) in size.
- To download/configure more fonts, just rerun the install flow: `make install`
- To remove st+ from your system, just run the uninstall flow: `make uninstall`


# Configuration

Configuration values such as font settings and alpha values will be stored in `~/.st.conf` for persistence, change this file if needed.

If this file does not exist or was deleted, it will be regenerated with safe defaults.

Supported configuration values: `font alpha rows cols`


# Contribute

If you like this work, please consider to:
- Please ⭐️ this repository if this project helped you.
- Buy the suckless.org team a cup of [coffee](https://suckless.org/donations/).

Credits to the following folk:
- Source code and patches merged from the official suckless project page: https://st.suckless.org
- The nerd-fonts team for providing the best versions of open source fonts: https://nerdfonts.com
- Ivan's portable2appimage script: https://github.com/ivan-hc/portable2appimage
- Open terminal python script adapted from Tilix: https://github.com/gnunn1/tilix
- Original simple terminal source code is based on Aurélien Aptel's 'bt'.
