# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=0

DESCRIPTION="Open Type Organizer"
HOMEPAGE="https://sourceforge.net/projects/oto/"
SRC_URI="https://download.sourceforge.net/oto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~ppc ~s390 ~sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS=( AUTHORS ChangeLog INSTALL NEWS README )

src_install() {
	emake DESTDIR="${D}" install || die
}
