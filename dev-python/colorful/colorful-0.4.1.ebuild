# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )

inherit distutils-r2

DESCRIPTION="Terminal string styling done right in Python"
HOMEPAGE="https://github.com/timofurrer/colorful"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r2_python_install
	find "${ED}" -name '*.pth' -delete || die
}
