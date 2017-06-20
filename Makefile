openbsd:  marblemouse-o doas noxcons
ubuntu: pkgs emacshelper mu4ehelper passmenu disablesshagent marblemouse-u
user: xmonadconf gpgconf sshconf git emacskeybindings


#
# OpenBSD system-level configs
# 
marblemouse-o:
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
	apt install xmonad stterm chromium-browser gnupg2 scdaemon libccid dirmngr gnupg-agent pinentry-gtk2 pcscd git xautolock xfonts-terminus suckless-tools pass pandoc xfce4-volumed emacs libssl-dev libgdal-dev libcurl4-openssl-dev lastpass-cli libudunits2-dev git

emacshelper: pkgs
	install -m755 Ubuntu/emacshelper /usr/bin/e

mu4ehelper: pkgs
	install -m755 Ubuntu/mu4ehelper /usr/bin/e-mail

passmenu: pkgs
	install -m755 /usr/share/doc/pass/examples/dmenu/passmenu /usr/bin/passmenu

disablesshagent:
	sed -i -e 's/^use-ssh-agent/# use-ssh-agent/' /etc/X11/Xsession.options

marblemouse-u:
	install -m644 Ubuntu/50-marblemouse.conf /usr/share/X11/xorg.conf.d

# 
# User-level configs
# 
xmonadconf:
	mkdir -p ${HOME}/.xmonad
	ln -sf `pwd`/xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs

gpgconf:
	mkdir -p ${HOME}/.gnupg
	chmod 700 ${HOME}/.gnupg
	install -m644 ./gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf

sshconf:
	echo "SSH_AUTH_SOCK=/run/user/`id -u`/gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;" >> ~/.profile

git:
	git config --global user.email "peter@thoughtspot.net"
	git config --global user.name "Peter Schmiedeskamp"

emacskeybindings:
	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs" # gtk3
	gconftool-2 --type=string --set /desktop/gnome/interface/gtk_key_theme Emacs # gtk2
