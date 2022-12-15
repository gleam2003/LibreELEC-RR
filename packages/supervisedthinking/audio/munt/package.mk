# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="munt"
PKG_VERSION="2.7.0"
PKG_SHA256="5ede7c3d28a3bb0d9e637935b8b96484fadb409c9e5952a9e5432b3e05e5dbc1"
PKG_LICENSE="LGPL-2.0-or-later"
PKG_SITE="https://github.com/munt/munt"
PKG_URL="https://github.com/munt/munt/archive/refs/tags/libmt32emu_${PKG_VERSION//./_}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A software synthesiser emulating pre-GM MIDI devices such as the Roland MT-32."

PKG_CMAKE_OPTS_TARGET="-D munt_WITH_MT32EMU_QT=0 \
                       -D munt_WITH_MT32EMU_SMF2WAV=0 \
                       -D libmt32emu_SHARED=1"
