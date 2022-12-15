# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="picodrive"
PKG_VERSION="0a4ec83cbfaebb65fb1c40f26ffaf28131f9003b"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="https://github.com/libretro/picodrive.git"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PicoDrive is a fast Megadrive / Genesis / Sega CD / Mega CD / 32X / SMS emulator."
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_LIBNAME="picodrive_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

configure_package() {
  # Cyclone 68000 emulator written in ARM 32-bit assembly
  if [ "${ARCH}" = "arm" ]; then
    PKG_DEPENDS_TARGET+=" ${PKG_NAME}:host"
  fi
}

pre_configure_host() {
  # Fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${HOST_NAME}

  # Build cyclone_gen as host binary to generate Cyclone.s which is later
  # used by https://github.com/libretro/picodrive/blob/master/platform/common/common.mak
  PKG_MAKE_OPTS_HOST="-C cpu/cyclone CONFIG_FILE=../cyclone_config.h"
}

make_host() {
  echo "Executing (host): make ${PKG_MAKE_OPTS_HOST}" | tr -s " "
  make ${PKG_MAKE_OPTS_HOST}
}

makeinstall_host() {
 :
}

pre_configure_target() {
  # Fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}

  # Common make opts
  PKG_MAKE_OPTS_TARGET="-f Makefile.libretro GIT_VERSION=${PKG_VERSION:0:7}"

  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=armv"
    # ARM NEON support
    if target_has_feature neon; then
      PKG_MAKE_OPTS_TARGET+="-neon"
    fi
  fi
}

make_target() {
  echo "Executing (target): make ${PKG_MAKE_OPTS_TARGET}" | tr -s " "
  make ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
