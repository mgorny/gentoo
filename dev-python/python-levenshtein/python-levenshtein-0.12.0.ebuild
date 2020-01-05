# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{6,7,8} )

inherit distutils-r1

MY_PN="python-Levenshtein"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Functions for fast computation of Levenshtein distance, and edit operations"
HOMEPAGE="
	https://github.com/ztane/python-Levenshtein/
	https://pypi.org/project/python-Levenshtein/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 ~ia64 x86"
IUSE="doc"

REQUIRED_USE="doc? ( || ( $(python_gen_useflags 'python2*' pypy) ) )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use doc && DISTUTILS_ALL_SUBPHASE_IMPLS=( 'python2*' pypy )
}

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation"
		"${EPYTHON}" "${FILESDIR}/genextdoc.py" Levenshtein \
			|| die "Generation of documentation failed"
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( Levenshtein.html )
	distutils-r1_python_install_all
}
