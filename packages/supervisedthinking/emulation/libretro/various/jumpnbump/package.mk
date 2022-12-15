# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="jumpnbump"
PKG_VERSION="5fd1a7c7757d2a73d8a49578155f0302d7794ac2"
PKG_SHA256="f7c48f449406869eb1d357718594c9d3bfe22b50b2bb733e668162e93a1609f6"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/jumpnbump-libretro"
PKG_URL="https://github.com/libretro/jumpnbump-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Jump n' Bump libretro core"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_LIBNAME="jumpnbump_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="GIT_VERSION=${PKG_VERSION:0:7}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
