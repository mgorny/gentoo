# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} pypy3 )

inherit distutils-r2

DESCRIPTION="A dot-accessible dictionary (a la JavaScript objects)"
HOMEPAGE="https://github.com/Infinidat/munch"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm64 ~hppa ~x86"
SLOT="0"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/munch-2.5.0-revert-pbr.patch"
)

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r2_python_prepare_all

	sed -i "s:__version__:'${PV}':" setup.py || die
}
