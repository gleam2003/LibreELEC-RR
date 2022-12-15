# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="soundtouch"
PKG_VERSION="2.3.2"
PKG_SHA256="ed714f84a3e748de87b24f385ec69d3bdc51ca47b7f4710d2048b84b2761e7ff"
PKG_LICENSE="LGPL-2.1"
PKG_SITE="https://codeberg.org/soundtouch/soundtouch"
PKG_URL="https://codeberg.org/soundtouch/soundtouch/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SoundTouch Audio Processing Library"
PKG_TOOLCHAIN="configure"

pre_configure_target() {
 cd ${PKG_BUILD}
 ${PKG_BUILD}/bootstrap
}
