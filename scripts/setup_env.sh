#!/bin/bash
TOPDIR="$(pwd)"

[ ! -f "${TOPDIR}/feeds.conf" ] && \
	cat "${TOPDIR}/blackwall/configs/feeds.conf" "${TOPDIR}/feeds.conf.default" > "${TOPDIR}/feeds.conf"

PATCHES_DIR="${TOPDIR}/blackwall/patches"
PKGS="mailsend"

for x in ${PKGS}; do
	d=$(find package/ -name ${x} | head -n1)
	[ -d "${d}" ] && {
		echo "Add ${x} patches"
		mkdir -p "${d}/patches"
		cp -rf ${PATCHES_DIR}/${x}/* "${d}/patches/."
	}
done

