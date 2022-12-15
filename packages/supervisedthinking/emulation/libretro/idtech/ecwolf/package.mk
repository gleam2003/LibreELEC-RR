# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="ecwolf"
PKG_VERSION="f098da0d003c4780adf6a9503801081f1f25cc27"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/ecwolf"
PKG_URL="https://github.com/libretro/ecwolf.git"
PKG_DEPENDS_TARGET="toolchain p7zip:host"
PKG_LONGDESC="Libretro port of ECWolf"
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="master"
PKG_GIT_CLONE_SINGLE="yes"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="+lto -sysroot"

PKG_LIBNAME="ecwolf_libretro.so"
PKG_LIBPATH="src/libretro/${PKG_LIBNAME}"

PKG_MAKE_OPTS_TARGET=" -C src/libretro GIT_VERSION=${PKG_VERSION:0:7}"

pre_make_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}

post_makeinstall_target() {
  echo -e "\n### Packaging ecwolf.pk3 data ####\n"
  mkdir -p ${INSTALL}/usr/share/retroarch/bios
    ${TOOLCHAIN}/bin/7za a -mx9 -tzip ${INSTALL}/usr/share/retroarch/bios/ecwolf.pk3 "${PKG_BUILD}/wadsrc/static/"* >/dev/null
}
