# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libogg-system"
PKG_VERSION="$(get_pkg_version ${PKG_NAME::-7})"
PKG_SHA256="$(get_pkg_sha256 ${PKG_NAME::-7})"
PKG_LICENSE="BSD"
PKG_SITE="https://www.xiph.org/ogg/"
PKG_URL="http://downloads.xiph.org/releases/ogg/libogg-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libogg contains necessary functionality to create, decode, and work with Ogg bitstreams."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DINSTALL_DOCS=OFF"
