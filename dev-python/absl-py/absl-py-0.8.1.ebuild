# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
inherit distutils-r2

DESCRIPTION="Abseil Python Common Libraries"
HOMEPAGE="https://github.com/abseil/abseil-py"
SRC_URI="https://github.com/abseil/abseil-py/archive/pypi-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/abseil-py-pypi-v${PV}"
