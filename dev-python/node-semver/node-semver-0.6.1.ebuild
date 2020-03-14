# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy3 python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Python version of node-semver, the semantic versioner for npm"
HOMEPAGE="
	https://pypi.org/project/node-semver/
	https://github.com/podhmo/python-semver
	https://github.com/npm/node-semver
"
# Tests are currently missing from PyPI tarballs
# https://github.com/podhmo/python-semver/pull/31
SRC_URI="https://github.com/podhmo/python-semver/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~hppa ~m68k ~sh ~x86 ~amd64-linux ~x86-linux"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

S="${WORKDIR}/python-semver-${PV}"

python_test() {
	# Ignore 2 tests that fail with Python 2
	# https://github.com/podhmo/python-semver/issues/30
	pytest -vv --ignore semver/tests/test_passing_bytes.py \
		|| die "tests failed with ${EPYTHON}"
}
