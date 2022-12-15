# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="libzip-system"
PKG_VERSION="$(get_pkg_version ${PKG_NAME::-7})"
PKG_SHA256="83e5d6d5dbe8f9df80aad388fa523ca3558398ed440a5afda6ef9b36b0ffdc1f"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://libzip.org/"
PKG_URL="https://github.com/nih-at/libzip/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib zstd"
PKG_LONGDESC="This is libzip, a C library for reading, creating, and modifying zip and zip64 archives."

PKG_CMAKE_OPTS_TARGET="-DENABLE_COMMONCRYPTO=OFF \
                       -DENABLE_GNUTLS=OFF \
                       -DENABLE_MBEDTLS=OFF \
                       -DENABLE_OPENSSL=OFF \
                       -DENABLE_WINDOWS_CRYPTO=OFF \
                       -DENABLE_BZIP2=OFF \
                       -DENABLE_LZMA=OFF \
                       -DENABLE_ZSTD=ON \
                       -DBUILD_TOOLS=OFF \
                       -DBUILD_REGRESS=OFF \
                       -DBUILD_EXAMPLES=OFF \
                       -DBUILD_DOC=OFF \
                       -DBUILD_SHARED_LIBS=ON"
