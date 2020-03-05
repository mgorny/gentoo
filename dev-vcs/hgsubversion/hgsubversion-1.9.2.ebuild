# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils-r2

DESCRIPTION="hgsubversion is a Mercurial extension for working with Subversion repositories"
HOMEPAGE="https://bitbucket.org/durin42/hgsubversion/wiki/Home https://pypi.org/project/hgsubversion/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-vcs/mercurial-1.4[${PYTHON_USEDEP}]
	|| (
		>=dev-python/subvertpy-0.7.4[${PYTHON_USEDEP}]
		>=dev-vcs/subversion-1.5[python] )
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

python_test() {
#	"${PYTHON}" tests/run.py || die "Tests failed under ${EPYTHON}"
	# Upstream is using nose and the other way simply runs no tests
	LC_ALL=C nosetests --verbose || die
}
