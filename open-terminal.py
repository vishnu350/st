# -*- coding: UTF-8 -*-
# Nautilus extension script for Suckless Terminal
# Copy this script to /usr/share/nautilus-python/extensions
# Uninstall nautilus-extension-gnome-terminal to avoid issues
# To debug this script, run "nautilus --no-desktop" in a terminal

from gettext import gettext, textdomain
from gi.repository import Gio, GObject, Nautilus
from subprocess import Popen
import shutil
import shlex
try:
    from urllib import unquote
    from urlparse import urlparse
except ImportError:
    from urllib.parse import unquote, urlparse

REMOTE_URI_SCHEME = ['ftp', 'sftp']
terminal_cmd: list[str] = ["st"]
textdomain("st")
_ = gettext

def _checkdecode(s):
    """Decode string assuming utf encoding if it's bytes, else return unmodified"""
    return s.decode('utf-8') if isinstance(s, bytes) else s

def open_terminal_in_file(filename):
    cmd = terminal_cmd.copy()
    if filename:
        cmd.append("-d")
        cmd.append(str(filename))
    Popen(cmd)  # pylint: disable=consider-using-with

class OpenTerminalExtension(GObject.GObject, Nautilus.MenuProvider):
    def _open_local_terminal(self, file_):
        """Open a new local terminal"""
        filename = Gio.File.new_for_uri(file_.get_uri()).get_path()
        open_terminal_in_file(filename)

    def _open_remote_terminal(self, file_):
        """Open a new remote terminal"""
        if file_.get_uri_scheme() in REMOTE_URI_SCHEME:
            result = urlparse(file_.get_uri())
            cmd = terminal_cmd.copy()
            cmd.extend(["ssh", "-t"])
            if result.username:
                cmd.append(f"{result.username}@{result.hostname}")
            else:
                cmd.append(result.hostname)
            if result.port:
                cmd.append("-p")
                cmd.append(str(result.port))
            cmd.extend(["cd", shlex.quote(unquote(result.path)), ";", "exec", "$SHELL", "-l"])
            Popen(cmd)  # pylint: disable=consider-using-with
        else:
            filename = Gio.File.new_for_uri(file_.get_uri()).get_path()
            open_terminal_in_file(filename)

    def _menu_activate_local_term_cb(self, menu, file_):
        self._open_local_terminal(file_)

    def _menu_activate_remote_term_cb(self, menu, file_):
        self._open_remote_terminal(file_)

    def get_file_items(self, *args):
        files = args[-1]
        if len(files) != 1:
            return
        items = []
        file_ = files[0]
        local_ = ''

        if file_.is_directory():
            if file_.get_uri_scheme() in REMOTE_URI_SCHEME:
                uri = _checkdecode(file_.get_uri())
                item = Nautilus.MenuItem(name='NautilusPython::open_remote_item',
                                         label=_(u'Open in Remote Terminal'),
                                         tip=_(u'Open a remote terminal in {}').format(uri))
                item.connect('activate', self._menu_activate_remote_term_cb, file_)
                items.append(item)
                local_ = 'Local '

            filename = _checkdecode(file_.get_name())
            item = Nautilus.MenuItem(name='NautilusPython::open_file_item',
                                     label=_(u'Open in {}Terminal'.format(local_)),
                                     tip=_(u'Open a local terminal in {}').format(filename))
            item.connect('activate', self._menu_activate_local_term_cb, file_)
            items.append(item)

        return items

    def get_background_items(self, *args):
        file_ = args[-1]
        items = []
        local_ = ''
        if file_.get_uri_scheme() in REMOTE_URI_SCHEME:
            item = Nautilus.MenuItem(name='NautilusPython::open_bg_remote_item',
                                     label=_(u'Open in Remote Terminal'),
                                     tip=_(u'Open a remote terminal in this directory'))
            item.connect('activate', self._menu_activate_remote_term_cb, file_)
            items.append(item)
            local_ = 'Local '

        item = Nautilus.MenuItem(name='NautilusPython::open_bg_file_item',
                                 label=_(u'Open in {}Terminal'.format(local_)),
                                 tip=_(u'Open a local terminal in this directory'))
        item.connect('activate', self._menu_activate_local_term_cb, file_)
        items.append(item)
        return items

