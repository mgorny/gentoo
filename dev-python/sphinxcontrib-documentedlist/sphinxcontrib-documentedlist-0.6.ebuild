# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )

inherit distutils-r2

DESCRIPTION="Sphinx extension to convert a Python list into a generated table"
HOMEPAGE="https://github.com/chintal/sphinxcontrib-documentedlist"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 ~x86"
IUSE=""

RDEPEND="
	dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r2_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
