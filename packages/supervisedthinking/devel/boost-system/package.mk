# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="boost-system"
PKG_VERSION="$(get_pkg_version ${PKG_NAME::-7})"
PKG_SHA256="$(get_pkg_sha256 ${PKG_NAME::-7})"
PKG_LICENSE="BSL-1.0"
PKG_SITE="http://www.boost.org/"
PKG_URL="https://boostorg.jfrog.io/artifactory/main/release/${PKG_VERSION}/source/boost_${PKG_VERSION//./_}.tar.bz2"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain boost-system:host Python3 zlib bzip2"
PKG_LONGDESC="Boost provides free peer-reviewed portable C++ source libraries."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

make_host() {
  cd tools/build/src/engine
    sh build.sh
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp b2 ${TOOLCHAIN}/bin
}

pre_configure_target() {
  export CFLAGS="${CFLAGS} -I${SYSROOT_PREFIX}/usr/include/${PKG_PYTHON_VERSION}"
  export CXXFLAGS="${CXXFLAGS} -I${SYSROOT_PREFIX}/usr/include/${PKG_PYTHON_VERSION}"
}

configure_target() {
  sh bootstrap.sh --prefix=/usr \
                  --with-bjam=${TOOLCHAIN}/bin/b2 \
                  --with-python=${TOOLCHAIN}/bin/python \
                  --with-python-root=${SYSROOT_PREFIX}/usr

  echo "using gcc : $(${CC} -v 2>&1  | tail -n 1 |awk '{print $3}') : ${CC}  : <compileflags>\"${CFLAGS}\" <linkflags>\"${LDFLAGS}\" ;" \
    > tools/build/src/user-config.jam
  echo "using python : ${PKG_PYTHON_VERSION/#python} : ${TOOLCHAIN} : ${SYSROOT_PREFIX}/usr/include : ${SYSROOT_PREFIX}/usr/lib ;" \
    >> tools/build/src/user-config.jam
}

makeinstall_target() {
  # Install files to sysroot
  ${TOOLCHAIN}/bin/b2 -d2 --ignore-site-config \
                          --layout=system \
                          --prefix=${SYSROOT_PREFIX}/usr \
                          --toolset=gcc link=shared \
                          --with-chrono \
                          --with-context \
                          --with-date_time \
                          --with-filesystem \
                          --with-iostreams \
                          --with-locale \
                          --with-nowide \
                          --with-program_options \
                          --with-python \
                          --with-random \
                          --with-regex -sICU_PATH="${SYSROOT_PREFIX}/usr" \
                          --with-serialization \
                          --with-system \
                          --with-thread \
                            install
  # Install files to target
  ${TOOLCHAIN}/bin/b2 -d2 --ignore-site-config \
                          --layout=system \
                          --prefix=${INSTALL}/usr \
                          --toolset=gcc link=shared \
                          --with-chrono \
                          --with-context \
                          --with-date_time \
                          --with-filesystem \
                          --with-iostreams \
                          --with-locale \
                          --with-nowide \
                          --with-program_options \
                          --with-python \
                          --with-random \
                          --with-regex -sICU_PATH="${SYSROOT_PREFIX}/usr" \
                          --with-serialization \
                          --with-system \
                          --with-thread \
                            install
}
