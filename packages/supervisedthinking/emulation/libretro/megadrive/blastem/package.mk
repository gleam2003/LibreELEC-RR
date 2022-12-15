# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="blastem"
PKG_VERSION="277e4a62668597d4f59cadda1cbafb844f981d45"
PKG_SHA256="1ad8eab6f528612d52f8310237d3e62a501e7449682369baa9eb5d4c73a6b90e"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/blastem"
PKG_URL="https://github.com/libretro/blastem/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Upstream tracking repo of BlastEm, the fast and accurate Genesis emulator, with libretro specific changes"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_LIBNAME="blastem_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
