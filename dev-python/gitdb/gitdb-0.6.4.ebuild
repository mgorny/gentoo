# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_6 )

inherit distutils-r2

DESCRIPTION="GitDB is a pure-Python git object database"
HOMEPAGE="
	https://github.com/gitpython-developers/gitdb
	https://pypi.org/project/gitdb/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND="dev-vcs/git
		>=dev-python/smmap-0.8.5[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
# Testsuite appears to require files from a git repo

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing"
	distutils-r2_python_compile
}
