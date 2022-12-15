# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="wxwidgets"
PKG_VERSION="3.2.1"
PKG_SHA256="c229976bb413eb88e45cb5dfb68b27890d450149c09b331abd751e7ae0f5fa66"
PKG_LICENSE="wxWidgets licence"
PKG_SITE="https://github.com/wxWidgets/wxWidgets"
PKG_URL="https://github.com/wxWidgets/wxWidgets/releases/download/v${PKG_VERSION}/wxWidgets-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libpng tiff mesa gtk3-system"
PKG_LONGDESC="wxWidgets is a free and open source cross-platform C++ framework for writing advanced GUI applications using native controls."

configure_package() {
  # Build with XCB support for X11
  if [ ${DISPLAYSERVER} = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libSM"
  elif [ ${DISPLAYSERVER} = "wl" ]; then
    PKG_DEPENDS_TARGET+=" wayland"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-Wno-dev"
}

post_makeinstall_target() {
  # Clean up
  safe_remove ${INSTALL}

  # Install libs
  mkdir -p ${INSTALL}/usr/lib
    cp -PR lib/libwx_baseu-${PKG_VERSION:0:3}*          ${INSTALL}/usr/lib
    cp -PR lib/libwx_gtk3u_core-${PKG_VERSION:0:3}*     ${INSTALL}/usr/lib
    cp -PR lib/libwx_gtk3u_adv-${PKG_VERSION:0:3}*      ${INSTALL}/usr/lib
    cp -PR lib/libwx_gtk3u_gl-${PKG_VERSION:0:3}*       ${INSTALL}/usr/lib
    cp -PR lib/libwx_gtk3u_propgrid-${PKG_VERSION:0:3}* ${INSTALL}/usr/lib

  # Fix wx-config paths
  WX_CONFIG_PATH=${SYSROOT_PREFIX}/usr/lib/wx/config/gtk3-unicode-${PKG_VERSION:0:3}
    ln -sf ${WX_CONFIG_PATH} ${SYSROOT_PREFIX}/usr/bin/wx-config
    sed -e "s:^prefix=.*:prefix=${PKG_ORIG_SYSROOT_PREFIX}/usr:g"                         -i ${WX_CONFIG_PATH}
    sed -e "s:^wxconfdir=.*:wxconfdir=\"${PKG_ORIG_SYSROOT_PREFIX}/usr/lib/wx/config\":g" -i ${WX_CONFIG_PATH}
    sed -e "s:^libdir=.*:libdir=\"${PKG_ORIG_SYSROOT_PREFIX}/usr/lib\":g"                 -i ${WX_CONFIG_PATH}
    sed -e "s:^bindir=.*:bindir=\"${PKG_ORIG_SYSROOT_PREFIX}/usr/bin\":g"                 -i ${WX_CONFIG_PATH}
}
