# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_6,3_7} )

inherit distutils-r2

DESCRIPTION="Extension providing a Sphinx domain for describing RESTful HTTP APIs"
HOMEPAGE="https://bitbucket.org/birkenfeld/sphinx-contrib/
	https://sphinxcontrib-httpdomain.readthedocs.io/en/stable/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86 ~amd64-linux ~x86-linux"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install_all() {
	distutils-r2_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
