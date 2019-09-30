# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools

DESCRIPTION="Sed-like editor for binary files"
HOMEPAGE="https://sourceforge.net/projects/bbe-/"
SRC_URI="https://download.sourceforge.net/${PN}-/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	sed -i -e '/^htmldir/d' doc/Makefile.am || die
	eaclocal
	eautoreconf
}

src_configure() {
	econf --htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
}
