# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Brag collects and assembles multipart binary attachments from newsgroups"
HOMEPAGE="http://brag.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/brag/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="
	dev-lang/tcl:0
	app-text/uudeview"

src_compile() { :; }

src_install() {
	dobin brag
	dodoc CHANGES README
	doman brag.1
}
