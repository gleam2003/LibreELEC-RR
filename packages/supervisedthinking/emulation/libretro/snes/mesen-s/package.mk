# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mesen-s"
PKG_VERSION="32a7adfb4edb029324253cb3632dfc6599ad1aa8"
PKG_SHA256="17e29212103691a3ae73862cd22c8d1dc6cdbb2b3750eac3dc1687d087d0cc05"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/Mesen-S"
PKG_URL="https://github.com/libretro/Mesen-S/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Mesen-S is a cross-platform (Windows & Linux) SNES emulator built in C++"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-sysroot"

PKG_LIBNAME="mesen-s_libretro.so"
PKG_LIBPATH="Libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET="-C Libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
