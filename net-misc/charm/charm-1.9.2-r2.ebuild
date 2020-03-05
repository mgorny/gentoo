# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL="1"

inherit distutils-r2

DESCRIPTION="A text based livejournal client"
HOMEPAGE="http://ljcharm.sourceforge.net/"
SRC_URI="mirror://sourceforge/ljcharm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

DEPEND="
	$(python_gen_cond_dep '
		dev-python/feedparser[${PYTHON_USEDEP}]
	')"

DOCS=( CHANGES.charm sample.charmrc README.charm )
HTML_DOCS=( charm.html )

pkg_setup() {
	python-single-r2_pkg_setup
}

python_prepare_all() {
	distutils-r2_python_prepare_all
	sed -e 's/("share\/doc\/charm", .*),/\\/' -i setup.py || die "sed failed"
}

pkg_postinst() {
	elog "You need to create a ~/.charmrc before running charm."
	elog "Read 'man charmrc' for more information."
}
