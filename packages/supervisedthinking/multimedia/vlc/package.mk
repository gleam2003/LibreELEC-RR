# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="vlc"
PKG_VERSION="3.0.18"
PKG_SHA256="6db9b84c569937a937d545d184473b5b9eba4eccef7a0da2e9f86053a298d837"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://www.videolan.org"
PKG_URL="https://code.videolan.org/videolan/vlc/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain dbus gnutls ffmpeg libmpeg2 zlib flac-system libvorbis-system"
PKG_LONGDESC="VideoLAN multimedia player and streamer"
PKG_TOOLCHAIN="configure"

configure_package() {
  # MMAL (Multimedia Abstraction Layer) support patches
  if [ "${OPENGLES}" = "bcm2835-driver" ]; then
    PKG_PATCH_DIRS="MMAL"
  fi

  # Mesa 3D support patch
  if [ "${OPENGLES}" = "mesa" ]; then
    PKG_PATCH_DIRS="OpenGL"
  fi

  # Build with OpenGL / OpenGLES support
  if [ "${OPENGL_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGL}"
  elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  fi

  if target_has_feature "(neon|sse)"; then
    PKG_DEPENDS_TARGET+=" dav1d libvpx-system"
  fi
}

pre_configure_target() {
  # bootstrap VLC
  # otherwhise build fails with [Makefile:28070: codec/webvtt/CSSGrammar.c] Error 1
  ${PKG_BUILD}/bootstrap

  PKG_CONFIGURE_OPTS_TARGET="--enable-silent-rules \
                             --disable-dependency-tracking \
                             --disable-nls \
                             --disable-rpath \
                             --disable-sout \
                             --disable-lua \
                             --disable-vlm \
                             --disable-taglib \
                             --disable-live555 \
                             --disable-dc1394 \
                             --disable-dvdread \
                             --disable-dvdnav \
                             --disable-opencv \
                             --disable-decklink \
                             --disable-sftp \
                             --disable-v4l2 \
                             --disable-vcd \
                             --disable-libcddb \
                             --disable-dvbpsi \
                             --disable-screen \
                             --enable-ogg \
                             --disable-shout\
                             --disable-mod \
                             --enable-mpc \
                             --disable-gme \
                             --disable-wma-fixed \
                             --disable-shine \
                             --disable-omxil \
                             --disable-mad \
                             --disable-merge-ffmpeg \
                             --enable-avcodec \
                             --enable-avformat \
                             --enable-swscale \
                             --enable-postproc \
                             --disable-faad \
                             --enable-flac \
                             --enable-aa \
                             --disable-twolame \
                             --disable-realrtsp \
                             --disable-libtar \
                             --disable-a52 \
                             --disable-dca \
                             --enable-libmpeg2 \
                             --enable-vorbis \
                             --disable-tremor \
                             --disable-speex \
                             --disable-theora \
                             --disable-schroedinger \
                             --disable-png \
                             --disable-x264 \
                             --disable-x26410b \
                             --disable-fluidsynth \
                             --disable-zvbi \
                             --disable-telx \
                             --disable-libass \
                             --disable-kate \
                             --disable-tiger \
                             --disable-xcb \
                             --disable-xvideo \
                             --disable-sdl-image \
                             --disable-freetype \
                             --disable-fribidi \
                             --disable-fontconfig \
                             --enable-libxml2 \
                             --disable-svg \
                             --disable-directx \
                             --disable-caca \
                             --disable-oss \
                             --enable-pulse \
                             --enable-alsa \
                             --disable-jack \
                             --disable-upnp \
                             --disable-skins2 \
                             --disable-kai \
                             --disable-qt \
                             --disable-macosx \
                             --disable-ncurses \
                             --disable-goom \
                             --disable-projectm \
                             --enable-udev \
                             --disable-mtp \
                             --disable-lirc \
                             --disable-libgcrypt \
                             --enable-gnutls \
                             --disable-update-check \
                             --disable-kva \
                             --disable-bluray \
                             --disable-samplerate \
                             --disable-sid \
                             --disable-crystalhd \
                             --disable-dxva2 \
                             --disable-aom \
                             --disable-gst-decode \
                             --disable-vlc"

  # X11 Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --with-x"
  else
    PKG_CONFIGURE_OPTS_TARGET+=" --without-x"
  fi

  # MMAL Support for RPi
  if [ "${OPENGLES}" = "bcm2835-driver" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-mmal"
  fi

  # OpenGL ES2 Support
  if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-gles2"
  fi

  # NEON Support
  if target_has_feature neon; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-neon"
  fi

  # libdav1d & libvpx Support
  if target_has_feature "(neon|sse)"; then
    PKG_CONFIGURE_OPTS_TARGET+=" --enable-dav1d \
                                 --enable-vpx"
  else
    PKG_CONFIGURE_OPTS_TARGET+=" --disable-dav1d \
                                 --disable-vpx"
  fi

  LDFLAGS+=" -lresolv"
}

post_configure_target() {
  # Fix linking to ffmpeg 4.4.y
  sed -i -e '/^archive_cmds=/s/ -shared / -Wl,-O1,--as-needed\0/'        ${PKG_BUILD}/libtool
  sed -i -e '/^archive_expsym_cmds=/s/ -shared / -Wl,-O1,--as-needed\0/' ${PKG_BUILD}/libtool
  sed -i -e 's/CC -shared /CC -Wl,-O1,--as-needed -shared /'             ${PKG_BUILD}/libtool
}

post_makeinstall_target() {
  # Clean up
  safe_remove ${INSTALL}/usr/share
}
