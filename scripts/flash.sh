#!/bin/bash
# ${0} TOPDIR [32|64]
TOPDIR="${1}"
BITS="${2}"

[ ! -d "${TOPDIR}" ] && \
	echo "Unknown TOPDIR" && exit

case "${BITS}" in
	32|64)
		;;
	*)
		echo "Unknown op-mode"
		exit
		;;
esac

. "${TOPDIR}/blackwall/scripts/strip_dotconfig.sh" "${TOPDIR}/.config"
[ ! -f "${TOPDIR}/blackwall/.config" ] &&
	echo "No blackwall .config(${TOPDIR}/blackwall/.config)" && exit
. "${TOPDIR}/blackwall/.config"

HDD=$(mount | grep "/media/${USER}/kernel" | cut -d' ' -f1 | sed -e 's,[0-9],,')
[ -z "${HDD}" ] && \
	HDD=$(blkid | grep 000f0995 | cut -d':' -f1 | sed -e 's,[0-9],,')

[ -z "${HDD}" ] && \
	echo "Unknown disk" && exit

mount | grep "/media/${USER}"
echo -en "\e[32mUnmount ${HDD} and flush [N|y] "
read ANS

case "${ANS}" in
	y|Y) echo "" ;;
	*) echo "Bye."; exit ;;
esac

sudo umount /media/${USER}/rootfs > /dev/null 2>&1
sudo umount /media/${USER}/kernel > /dev/null 2>&1

IMG_DIR="bin/targets/${CONFIG_TARGET_BOARD}/${CONFIG_TARGET_SUBTARGET}"
IMGNAME="$(echo ${CONFIG_VERSION_DIST} | tr '[:upper:]' '[:lower:]')"
IMGNAME="${IMGNAME}-${CONFIG_VERSION_NUMBER}"
IMGNAME="${IMGNAME}-${CONFIG_VERSION_CODE}"
IMGNAME="${IMGNAME}-${CONFIG_TARGET_BOARD}"
IMGNAME="${IMGNAME}-${CONFIG_TARGET_SUBTARGET}"
IMGNAME="${IMGNAME}-combined"
IMGNAME="${IMGNAME}-ext4"
IMGNAME="${IMGNAME}.img"

[ ! -f "${IMG_DIR}/${IMGNAME}" ] && \
	echo "No such image(${IMG_DIR}/${IMGNAME})" && exit

sudo dd if=${IMG_DIR}/${IMGNAME} of=${HDD} bs=1M

