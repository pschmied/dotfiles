all:  marblemouse doas noxcons

marblemouse:
	install -m644 ./OpenBSD/50-marblemouse.conf /usr/X11R6/share/X11/xorg.conf.d/

doas:
	install -m644 ./OpenBSD/doas.conf /etc/

noxcons:
	sed -e 's/^[[:space:]][[:space:]]*xconsole/#xconsole/' /etc/X11/xdm/Xsetup_0 > /tmp/Xsetup_0; install -m644 /tmp/Xsetup_0 /etc/X11/xdm/Xsetup_0
