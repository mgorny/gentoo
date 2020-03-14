# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python2_7 python3_{6,7,8} pypy3 )

inherit distutils-r1 eutils

DESCRIPTION="A built-package format for Python"
HOMEPAGE="https://pypi.org/project/wheel/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/pypa/wheel/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~hppa ~m68k ~sh ~x86"

distutils_enable_tests pytest

src_prepare() {
	sed \
		-e 's:--cov=wheel::g' \
		-i setup.cfg || die
	distutils-r1_src_prepare
}
