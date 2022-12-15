# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="mupen64plus-gui"
PKG_VERSION="f454370d5d7d05e67317ac48fa45aefe0fdedf9f"
PKG_SHA256="7d05c8ae69d63b13ce420c1c85a94f0eb77e1a2336a49e287714f7fac7019688"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/simple64/simple64-gui"
PKG_URL="https://github.com/simple64/simple64-gui/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc sdl2 qt5 p7zip-system libpng zlib mupen64plus-core"
PKG_LONGDESC="mupen64plus GUI written in Qt5"
PKG_TOOLCHAIN="manual"

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xorg-server"
  fi

  # OpenGL Support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  fi

  # OpenGLES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi
}

configure_target() {
  export SYSROOT_PREFIX=${SYSROOT_PREFIX}
  echo "#define GUI_VERSION" \"${PKG_VERSION:0:7}\" > ${PKG_BUILD}/version.h
}

make_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cd .${TARGET_NAME}
  qmake ${PKG_BUILD}/mupen64plus-gui.pro INCLUDEPATH="$(get_build_dir mupen64plus-core)/src/api"
  make -j${CONCURRENCY_MAKE_LEVEL}
}
