# Debian Simple Terminal (st)

Simple Terminal, a lightweight (~100KB) terminal with essential features and rock-solid stability for daily use. Best used with tmux.

This is a fork of st from [suckless.org](https://st.suckless.org) for Gnome-based distros such as Debian, Ubuntu, and Linux Mint. It is integrated with a minimal collection of patches along with proper Nautilus integration for ease of use:
- Configuration file in `~/.st.conf` (eg. changing font settings)
- Proper "Open Terminal Here" integration for Nautilus:
  - Supports "Open in Remote/Local Terminal" for remote connections.
- Scrollback (Shift+Mouse Scroll or Shift+PgUp/PgDn)
- Working directory (needed for Nautilus integration)
- Desktop entry (for menu shortcuts)
- Alpha (transparent backgrounds)
- Blinking cursor (Square Box)
- One clipboard (better cut/paste)
- Fullscreen support (F11/Alt-Enter)
- Solarized dark
- Fira Code Nerd Fonts

st is a simple terminal emulator for X which sucks less. See their philosophy [here](https://suckless.org/philosophy).


# [Motivation](https://st.suckless.org)

Here's an excerpt from the **xterm(1) README**:

> Abandon All Hope, Ye Who Enter Here

> This is undoubtedly the most ugly program in the distribution. It was one of the first "serious" programs ported, and still has a lot of historical baggage. Ideally, there would be a general tty widget and then vt102 and tek4014 subwidgets so that they could be used in other programs. We are trying to clean things up as we go, but there is still a lot of work to do.

It has over 65K lines of code and emulates obscure and obsolete terminals you will never need.

The popular alternative, rxvt has only 32K lines of code. This is just too much for something as simple as a terminal emulator; it's yet another example of code complexity.

Terminal emulation doesn't need to be so complex.


# Configuration

Configuration values such as font settings and alpha values will be stored in `~/.st.conf` for persistence, change this file if needed.

If this file does not exist or was deleted, it will be regenerated with safe defaults.


# Installation (Manual Build)

You need the following packages:

    sudo apt install build-essential libxft-dev pkg-config python3-nautilus

To avoid conflicts, default nautilus open terminal extension should be removed:

    sudo apt remove nautilus-extension-gnome-terminal

To compile and install Debian st:

    git clone https://github.com/vishnu350/st
    cd st && make patch
    sudo make install
    fc-cache -fv

This installation method will also bundle and enable Fira Code Nerd fonts by default.


# Credits

- Patches merged from official suckless project page: [https://st.suckless.org](https://st.suckless.org)
- Open terminal python script adapted from Tilix: [https://github.com/gnunn1/tilix](https://github.com/gnunn1/tilix)
- Based on Aurélien APTEL <aurelien dot aptel at gmail dot com> bt source code.

