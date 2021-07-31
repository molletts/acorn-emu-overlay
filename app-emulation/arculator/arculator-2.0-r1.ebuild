# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit autotools

DESCRIPTION="Emulator for classic ARM-based Acorn Archimedes-family computers"
HOMEPAGE="http://b-em.bbcmicro.com/arculator/"
SRC_URI="http://b-em.bbcmicro.com/arculator/Arculator_V${PV}_Linux.tar.gz -> ${PN}-${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+release debug"
REQUIRED_USE="release? ( !debug )"

RDEPEND="media-libs/libsdl2
         media-libs/openal
         x11-libs/wxGTK"
DEPEND="${RDEPEND}"

PATCHES=(
    "${FILESDIR}"/${PN}-2.0-fix-duplicate-arm3cp.patch
    "${FILESDIR}"/${PN}-2.0-fix-release-build.patch
    "${FILESDIR}"/${PN}-2.0-fix-sigsegv.patch
    "${FILESDIR}"/${PN}-2.0-honour-CFLAGS.patch
)

src_prepare() {
    # Fix line endings so that ${PN}-2.0-fix-duplicate-arm3cp.patch applies
    sed -i -e 's/\r$//' src/cp15.c src/cp15.h \
        || die "sed failed while fixing up line endings"
    default

    eautoreconf
}

src_configure() {
    local LIBDIRVAR="LIBDIR_${ABI}"
	econf $(usex release --enable-release-build '') \
          $(use_enable debug) \
          --libdir="${EPREFIX}/usr/${!LIBDIRVAR}/arculator"
}

src_install() {
	emake DESTDIR="${D}" install
}
