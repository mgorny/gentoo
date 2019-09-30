# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4
inherit eutils

DESCRIPTION="Simple but powerful unit testing framework for C++"
HOMEPAGE="http://cpptest.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

DOCS=( AUTHORS BUGS NEWS README )

src_configure() {
	econf \
		$(use_enable doc) \
		--htmldir=/usr/share/doc/${PF}/html/
}

src_install() {
	default
	prune_libtool_files
}
