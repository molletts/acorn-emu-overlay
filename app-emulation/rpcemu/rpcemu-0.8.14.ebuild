# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Emulator for classic ARM-based Acorn computers such as the RiscPC"
HOMEPAGE="http://www.marutan.net/rpcemuspoon/"
SRC_URI="http://www.marutan.net/rpcemuspoon/cgi/download.php?sFName=${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dynarec"

RDEPEND="media-libs/allegro:0"
DEPEND="${RDEPEND}"

ECONF_SOURCE="src"

src_configure() {
	econf $(use_enable dynarec)
}

src_install() {
	emake DESTDIR="${D}" install
}
