# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r2

DESCRIPTION="py.test plugin for isort"
HOMEPAGE="https://github.com/moccu/pytest-isort https://pypi.python.org/pypi/pytest-isort"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="
	>=dev-python/isort-4.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-3.5[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

python_test() {
	py.test -vs --cache-clear || die "testsuite failed under ${EPYTHON}"
}
