# Simple Terminal+ (st+)

<img src="https://github.com/user-attachments/assets/14914cf1-5bfb-4f2f-859e-5d15da46ade0" alt="drawing" width="50%"/>

Modern terminal emulators have grown bloated, packing in features you'll never use, emulating obscure terminals you'll never need, and offloads to GPUs you'll never afford.

Simple Terminal+ is a beautiful yet lightweight Linux terminal (~100KB) with essential features and rock-solid stability for daily use. It is best used with tmux combined with a [nerd-fonts](https://www.nerdfonts.com/) of your choice.

This is a fork of [st](https://st.suckless.org) that bundles a curated set of patches and quality-of-life features:
- **Features SIXEL support!** Allows editors such as Neovim to display images via [plugins](https://github.com/3rd/image.nvim).
- Automatically install a [nerd-font](https://www.nerdfonts.com/) or download a beautiful [Gogh](https://gogh-co.github.io/Gogh/) color scheme via the `st-config` command.
- Customizable color scheme with built-in support for over 300+ [Gogh](https://gogh-co.github.io/Gogh/) color schemes.
- Proper "Open Terminal Here" integration for Nautilus, including "Open in Remote/Local Terminal" for remote connections.
- Minimal configuration file in `~/.st.conf` to store all settings.
- Auto-calculate default font size (Shift+Ctrl+PgUp/PgDn to change).
- Scrollback (Shift+Mouse Scroll or Shift+PgUp/PgDn).
- Working directory (needed for "Open Terminal Here" integration).
- Desktop entry (for menu shortcuts).
- Transparent backgrounds (alpha value).
- Blinking cursor (square box).
- One clipboard (better cut/paste).
- Fullscreen support (F11/Alt-Enter).
- AppImage version will work even on 10 year old distros.
- Easy AppImage install flow via AM: `am i st+`

If you just want an AppImage of a fast, minimal, lightweight, rock-solid terminal that supports SIXEL and other essential features, then st+ is for you.


# Benchmarking

Performance benchmarking on a decent machine:
| Terminal | Avg Time | Speed | Benchmark Command |
|:-----|------|------------|:---------------------|
| **ST+** | **0.022s** | **8.3×** | `time st+ -e bash printf 'ABCDEFGHIJ0123456789%.0s\n' {1..5}` |
| GNOME Terminal | 0.182s | 1.0× | `time gnome-terminal -- bash printf 'ABCDEFGHIJ0123456789%.0s\n' {1..5}` |
| XTERM | 0.033s | 5.5× | `time xterm -e bash printf 'ABCDEFGHIJ0123456789%.0s\n' {1..5}` |


# Installation (AppImage)

The recommended AppImage installation method is through Ivan's [AM/Appman](https://github.com/ivan-hc/AM):

    am -i st+

Or just download it from the [release section](https://github.com/vishnu350/st/releases), rename it to **st+** and place it in your system $PATH.

To set color schemes or download more fonts, run the st-config tool from within the st+ terminal:

    $APPDIR/st-config

This utility will allow you to change the color scheme, download/configure a nerd-font of your choice, or install the terminfo/manpage/nautilus extension if needed.

Notes on AppImage install flow:
- [AM/Appman](https://github.com/ivan-hc/AM) supports auto-updates with checksum integrity verification.
- AppImages will be larger in size, but there will be virtually zero difference in performance.
- To remove st+ from your system: `$APPDIR/st-config uninstall`


# Installation (Manual Build)

You will need the following packages (Debian example below):

    sudo apt install build-essential libxft-dev libimlib2-dev pkg-config wget python3-nautilus

To avoid conflicts, the default nautilus open terminal extension should be removed if installed:

    sudo apt remove nautilus-extension-gnome-terminal

To compile and install st+ (needs root, flags can be combined):

    git clone https://github.com/vishnu350/st && cd st
    make install                                      ## Standard install
    make install SYSICON=1                            ## Desktop shortcut will use system icon
    make install CFLAGS="-O3 -march=native -flto"     ## Optimize for highest performance
    make install CFLAGS="-Os -march=native -flto"     ## Optimize for size (~85KB)

To set color schemes or download more fonts, run the st-config tool:

    st-config

**Only for release**: To build AppImage and static binaries for distribution/release, run the following command from within an old container (st-build.dockerfile):

    make dist STATIC=1 CFLAGS="-O3 -flto"

Notes on manual install flow:
- No auto-updates.
- Compiled binary size will be tiny (~100KB) in size.
- To remove st+ from your system: `st-config uninstall` or `make uninstall`


# Configuration

Configuration values such as font settings and alpha values will be stored in `~/.st.conf` for persistence, change this file if needed.

If this file does not exist or was deleted, it will be regenerated with safe defaults.

Supported configuration values: `font rows cols alpha colorname`

For the nautilus extension to work make sure to install `python3-nautilus`, but remove `nautilus-extension-gnome-terminal` to avoid conflict.


# Contribute

Like this project?
- Please ⭐️ this repository and follow the devs if this project helped you.
- Buy the suckless.org team a cup of [coffee](https://suckless.org/donations/).

Credits to the following folk:
- Source code and patches merged from the official suckless project page: https://st.suckless.org
- The nerd-fonts team for providing the best versions of open source fonts: https://nerdfonts.com
- The Gogh-Co team for the best looking color schemes out there: https://gogh-co.github.io/Gogh
- Ivan's portable2appimage script: https://github.com/ivan-hc/portable2appimage
- Open terminal python script adapted from Tilix: https://github.com/gnunn1/tilix
- Original simple terminal source code is based on Aurélien Aptel's 'bt'.
