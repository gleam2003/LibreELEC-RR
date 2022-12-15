# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="common-overlays-lr"
PKG_VERSION="b3827a2c63834ed9e1902acc7cf9019f64771ed3"
PKG_SHA256="a19e8f78c3beea65954b445faa9aefa8b3f531acfd1b1ea6c5e4d0b848ea6314"
PKG_LICENSE="CC-BY-4.0 License"
PKG_SITE="https://github.com/libretro/common-overlays"
PKG_URL="https://github.com/libretro/common-overlays/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET=""
PKG_LONGDESC="Collection of overlay files for use with libretro frontends, such as RetroArch."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/share/retroarch/overlays"
}

post_makeinstall_target() {
  for PKG_OVERLAY_FILES in \
    gamepads ipad keyboards misc wii
  do
    safe_remove ${INSTALL}/usr/share/retroarch/overlays/${PKG_OVERLAY_FILES}
  done 
}
