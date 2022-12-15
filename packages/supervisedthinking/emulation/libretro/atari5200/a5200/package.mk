# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="a5200"
PKG_VERSION="b8f8571eb5c6f484fe6be9a3a895ffb162b08422"
PKG_SHA256="ea7e8d424e345c5eee3caf30f297286e9a3298719890d6b1f4b47d2d11d48050"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/a5200"
PKG_URL="https://github.com/libretro/a5200/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Atari 5200 emulator for GCW0"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_LIBNAME="a5200_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
