# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="bsnes-hd"
PKG_VERSION="04821703aefdc909a4fd66d168433fcac06c2ba7"
PKG_SHA256="f3c5b4480c412af869fd0b050c80160308acdc5feb6a5c017dbcb9dd5fd6a725"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/DerKoun/bsnes-hd"
PKG_URL="https://github.com/DerKoun/bsnes-hd/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="bsnes-hd is a fork of bsnes that adds HD video features."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto +speed -sysroot"

PKG_LIBNAME="bsnes_hd_beta_libretro.so"
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
