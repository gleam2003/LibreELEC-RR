# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017 Escalade
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="at-spi2-core"
PKG_VERSION="2.46.0"
PKG_SHA256="aa0c86c79f7a8d67bae49a5b7a5ab08430c608cffe6e33bf47a72f41ab03c3d0"
PKG_LICENSE="OSS"
PKG_SITE="https://www.gnome.org/"
PKG_URL="https://download.gnome.org/sources/at-spi2-core/${PKG_VERSION:0:4}/at-spi2-core-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain atk dbus glib"
PKG_LONGDESC="Protocol definitions and daemon for D-Bus at-spi."

configure_package() {
  # Build with x11 support
  if [ ${DISPLAYSERVER} = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libXtst"
  fi
}

pre_configure_target() {
  PKG_MESON_OPTS_TARGET="-Ddocs=false \
                         -Dintrospection=no \
                         -Ddbus_daemon=/usr/bin/dbus-daemon"

  if [ ${DISPLAYSERVER} = "x11" ]; then
    PKG_MESON_OPTS_TARGET+="-Dx11=true"
    TARGET_LDFLAGS="${LDFLAGS} -lXext"
  else
    PKG_MESON_OPTS_TARGET+="-Dx11=false"
  fi
}
