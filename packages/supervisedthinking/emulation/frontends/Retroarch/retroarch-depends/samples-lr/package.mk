# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="samples-lr"
PKG_VERSION="bce193bc1b8c9a3da43b2ead0158a69e28b37ed8"
PKG_SHA256="53ae296dbb5b6d8a4fe2b25a8c810b7644490536bcdd603ab912bb102640b8ef"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-samples"
PKG_URL="https://github.com/libretro/libretro-samples/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="A set of samples to illustrate libretro API."
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

  # OpenGL ES Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi

  # Vulkan support
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${VULKAN}"
  fi
}

make_target() {
  make -C input/button_test
  make -C midi/midi_test
  make -C tests/test

  if [ "${ARCH}" = "x86_64" ]; then
    make -C tests/test_advanced
  fi

  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    make -C video/opengl/libretro_test_gl_fixedfunction
    make -C video/opengl/libretro_test_gl_shaders
  fi

  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    make -C video/vulkan/vk_rendering
    make -C video/vulkan/vk_async_compute
  fi
}

makeinstall_target() {
  # Install common test cores
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp input/button_test/*.so ${INSTALL}/usr/lib/libretro/
    cp midi/midi_test/*.so    ${INSTALL}/usr/lib/libretro/
    cp tests/test/*.so        ${INSTALL}/usr/lib/libretro/

  # Install Advanced test cores
  if [ "${ARCH}" = "x86_64" ]; then
    cp tests/test_advanced/*.so ${INSTALL}/usr/lib/libretro/
  fi

  # Install OpenGL test cores
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    cp video/opengl/libretro_test_gl_fixedfunction/*.so ${INSTALL}/usr/lib/libretro/
    cp video/opengl/libretro_test_gl_shaders/*.so       ${INSTALL}/usr/lib/libretro/
  fi

  # Install Vulkan test cores
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    cp video/vulkan/vk_rendering/*.so     ${INSTALL}/usr/lib/libretro/
    cp video/vulkan/vk_async_compute/*.so ${INSTALL}/usr/lib/libretro/
  fi
}
