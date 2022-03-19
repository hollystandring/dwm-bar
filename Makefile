DESTDIR = /usr/local
BINDIR = ${DESTDIR}/bin/dwm-bar
MODDIR = ${DESTDIR}/share/dwm-bar-modules

install:
	cp ${CURDIR}/dwm_bar.sh ${BINDIR}
	mkdir -p ${DESTDIR}/share/dwm-bar-modules
	cp -a ${CURDIR}/modules/. ${MODDIR}
uninstall:
	rm -rf ${BINDIR} ${MODDIR}