# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="genesis-plus-gx-wide"
PKG_VERSION="f634cc53fd8dd8c09a24aac5314d147635857e62"
PKG_SHA256="93ae52d407df51908f0b9cae28d29a9652e7a6b0ac4577b8051a5c262dba012a"
PKG_LICENSE="Modified BSD / LGPL-2.1-or-later"
PKG_SITE="https://github.com/libretro/Genesis-Plus-GX-Wide"
PKG_URL="https://github.com/libretro/Genesis-Plus-GX-Wide/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Widescreen modification of Genesis Plus GX"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="genesis_plus_gx_wide_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro GIT_VERSION=${PKG_VERSION:0:7}"

pre_configure_target() {
  case ${PROJECT} in
    Amlogic)
      PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
      ;;
    RPi)
      case ${DEVICE} in
        RPi)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi"
          ;;
        RPi2)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi2"
          ;;
        RPi4)
          PKG_MAKE_OPTS_TARGET+=" platform=rpi4"
          ;;
      esac
      ;;
    Rockchip)
        PKG_MAKE_OPTS_TARGET+=" platform=${DEVICE}"
      ;;
    *)
      if [ "${ARCH}" = "arm" ]; then
        PKG_MAKE_OPTS_TARGET+=" platform=armv"
        CFLAGS+=" -DALIGN_LONG"
      fi
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
