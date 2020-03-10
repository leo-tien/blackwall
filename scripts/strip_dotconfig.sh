#!/bin/bash
DOTCONFIG="${1}"
[ ! -f "${DOTCONFIG}" ] && \
	echo -en "No such file(${DOTCONFIG})\n" && exit 1

TOPDIR="$(dirname ${DOTCONFIG})"
BW_DIR="$(dirname ${0})/.."

#exit
cat "${DOTCONFIG}" | \
	sed -e '/^#/d' \
		-e 's,(,{,g' \
		-e 's,),},g' \
		-e ':a s,^\([^=]*\)\-,\1_,; t a' \
		-e 's,[()],,g' \
		> "${BW_DIR}/.config"

