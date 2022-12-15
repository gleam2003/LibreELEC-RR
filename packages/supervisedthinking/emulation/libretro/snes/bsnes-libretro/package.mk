# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="bsnes-libretro"
PKG_VERSION="7679cb9618c37c9044158d5cf3da28ef25afa9af"
PKG_SHA256="1d62469295ac3aba006f9de61f7210d4f309d91ba1d27a187e5083cd8ba165b6"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/bsnes-libretro"
PKG_URL="https://github.com/libretro/bsnes-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="bsnes is a Super Nintendo (SNES) emulator focused on performance, features, and ease of use."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="bsnes_libretro.so"
PKG_LIBPATH="bsnes/out/${PKG_LIBNAME}"

configure_target(){
  PKG_MAKE_OPTS_TARGET="-C bsnes \
                        -f GNUmakefile \
                        compiler=${CXX} \
                        target=libretro \
                        platform=linux \
                        local=false \
                        binary=library"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
