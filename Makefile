all:  marblemouse

marblemouse:
	install -m644 ./OpenBSD/50-marblemouse.conf /usr/X11R6/share/X11/xorg.conf.d/
