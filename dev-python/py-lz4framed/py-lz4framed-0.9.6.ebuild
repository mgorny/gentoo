# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )
inherit distutils-r2

DESCRIPTION="LZ4Frame library for Python (via C bindings)"
HOMEPAGE="https://pypi.org/project/py-lz4framed/ https://github.com/Iotic-Labs/py-lz4framed"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	${EPYTHON} -m unittest discover -v . || die
}
