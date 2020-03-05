# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_6 )

inherit distutils-r2 vcs-snapshot

DESCRIPTION="Fast and simple packet creation and parsing library for Python"
HOMEPAGE="https://github.com/mike01/pypacker"
SRC_URI="https://github.com/mike01/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( AUTHORS CHANGES HACKING README.md )

python_test() {
	"${PYTHON}" tests/test_pypacker.py || die
}

python_install_all() {
	distutils-r2_python_install_all
	use examples && dodoc -r examples
}
