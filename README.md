# Debian Suckless Terminal (st)

This is a fork of st from [suckless.org](https://st.suckless.org) for Gnome-based distros such as Debian, Ubuntu, and Linux Mint. It is integrated with a minimal collection of patches along with proper Nautilus integration for ease of use:
- Proper "Open Terminal Here" integration for Nautilus:
  - Supports "Open in Remote/Local Terminal" for remote connections.
- Scrollback (Shift+Mouse Scroll or Shift+PgUp/PgDn)
- Working directory (needed for Nautilus integration)
- Desktop entry (for menu shortcuts)
- Alpha (transparent backgrounds)
- Blinking cursor (Square Box)
- Swap mouse cursor (for VIM/etc)
- One clipboard (better cut/paste)
- Fullscreen support (F11/Alt-Enter)
- Solarized dark
- Fira Code Nerd Fonts

st is a simple terminal emulator for X which sucks less. See their philosophy [here](https://suckless.org/philosophy).


# Requirements

In order to properly build Debian st you need the following packages:
    
    sudo apt install build-essential libxft-dev pkg-config python3-nautilus

To avoid conflicts, default nautilus open terminal extension should be removed:
    
    sudo apt purge nautilus-extension-gnome-terminal

Usage of tmux is recommended.


# Installation

To install Debian st: Clone, apply the patches, make install as root, and rebuild the font cache.

    git clone https://github.com/vishnu350/st
    make patch
    sudo make install
    fc-cache -fv

To customize common settings, edit the files below prior to running make patch:
- Font settings: patches/st-vish.diff (line 10)
- Transparency value: patches/st-alpha-swapmouse.diff (line 10)


# Running st

If you did not install st with make clean install, you must compile
the st terminfo entry with the following command:

    tic -sx st.info

See the man page for additional details.

# Credits

- Patches merged from official suckless project page: [https://st.suckless.org](https://st.suckless.org)
- Open terminal python script adapted from Tilix: [https://github.com/gnunn1/tilix](https://github.com/gnunn1/tilix)
- Based on Aurélien APTEL <aurelien dot aptel at gmail dot com> bt source code.

