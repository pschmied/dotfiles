openbsd:  marblemouse doas noxcons
ubuntu: pkgs emacshelper passmenu disablesshagent
user: xmonadconf

#
# OpenBSD system-level configs
# 
marblemouse:
	install -m644 OpenBSD/50-marblemouse.conf /usr/X11R6/share/X11/xorg.conf.d/

doas:
	install -m644 OpenBSD/doas.conf /etc/

noxcons:
	sed -e 's/^[[:space:]][[:space:]]*xconsole/#xconsole/' /etc/X11/xdm/Xsetup_0 > /tmp/Xsetup_0
	install -m644 /tmp/Xsetup_0 /etc/X11/xdm/Xsetup_0

#
# Ubuntu system-level configs
# 
pkgs:
	apt install xmonad stterm chromium-browser gnupg2 scdaemon libccid dirmngr gnupg-agent pinentry-gtk2 pcscd git xautolock xfonts-terminus suckless-tools pass offlineimap mu4e pandoc

emacshelper: pkgs
	install -m755 Ubuntu/emacshelper /usr/bin/e

passmenu: pkgs
	install -m755 /usr/share/doc/pass/examples/dmenu/passmenu /usr/bin/passmenu

disablesshagent:
	sed -i -e 's/^use-ssh-agent/# use-ssh-agent/' /etc/X11/Xsession.options

# 
# User-level configs
# 
xmonadconf:
	mkdir -p ${HOME}/.xmonad
	ln -sf `pwd`/xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs
	ln -sf `pwd`/xmonad/xsession ${HOME}/.xsession

gpgconf:
	mkdir -p ${HOME}/.gnupg
	chmod 700 ${HOME}/.gnupg
	ln -sf `pwd`/gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf
