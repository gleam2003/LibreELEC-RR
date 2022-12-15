# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="capsimg"
PKG_VERSION="ed4cb0912fb1a2a0d5203111c6f6abd50d411b56"
PKG_SHA256="32f37abcdf41a72414e216e80e730aa7d6c1522f0b3bb86fd193844b9dfef626"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/FrodeSolheim/capsimg"
PKG_URL="https://github.com/FrodeSolheim/capsimg/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SPS Decoder Library 5.1 (formerly IPF Decoder Lib)"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C CAPSImg"

pre_configure_target() {
  cd $PKG_BUILD
  ./bootstrap
  ./configure --host=${TARGET_NAME}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib
    cp -v  CAPSImg/libcapsimage.so.5.1 ${INSTALL}/usr/lib/
    ln -sf libcapsimage.so.5.1 ${INSTALL}/usr/lib/libcapsimage.so.5
    ln -sf libcapsimage.so.5.1 ${INSTALL}/usr/lib/libcapsimage.so
  mkdir -p ${INSTALL}/usr/share/retroarch/bios/
    ln -sf /usr/lib/libcapsimage.so.5.1 ${INSTALL}/usr/share/retroarch/bios/capsimg.so
}
