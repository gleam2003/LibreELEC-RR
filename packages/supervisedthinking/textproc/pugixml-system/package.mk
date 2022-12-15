# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pugixml-system"
PKG_VERSION="$(get_pkg_version ${PKG_NAME::-7})"
PKG_SHA256="$(get_pkg_sha256 ${PKG_NAME::-7})"
PKG_LICENSE="MIT"
PKG_SITE="https://pugixml.org/"
PKG_URL="https://github.com/zeux/pugixml/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Light-weight, simple and fast XML parser for C++ with XPath support."
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON"
