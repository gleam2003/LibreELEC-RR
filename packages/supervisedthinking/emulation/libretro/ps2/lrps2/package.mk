# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="lrps2"
PKG_VERSION="61a6af54c5af1a03ed048d83252de96971b1fd0a"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://github.com/libretro/LRPS2"
PKG_URL="https://github.com/libretro/LRPS2.git"
PKG_DEPENDS_TARGET="toolchain xz zlib libaio"
PKG_LONGDESC="Hard fork / port of PCSX2. Will target only Libretro specifically."
GET_HANDLER_SUPPORT="git"
PKG_GIT_CLONE_BRANCH="main"
PKG_GIT_CLONE_SINGLE="yes"

PKG_LIBNAME="pcsx2_libretro.so"
PKG_LIBPATH="pcsx2/${PKG_LIBNAME}"

configure_package() {
  # OpenGL support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON"
}

pre_make_target() {
  # fix cross compiling
  find ${PKG_BUILD} -name flags.make -exec sed  -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_LIBPATH} ${INSTALL}/usr/lib/libretro/
}
