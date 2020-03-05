# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_6 )

inherit distutils-r2

DESCRIPTION="A sphinx extension for embedding block diagrams using blockdiag"
HOMEPAGE="https://github.com/blockdiag/sphinxcontrib-blockdiag"
SRC_URI="https://github.com/blockdiag/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
	>=dev-python/blockdiag-1.5.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/namespace-sphinxcontrib[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -i -e /build-base/d setup.cfg || die
	distutils-r2_python_prepare_all
}

python_install_all() {
	distutils-r2_python_install_all
	find "${ED}" -name '*.pth' -delete || die
}
