# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r2 vcs-snapshot

COMMIT="9f54e1aa3a87ec176ce8b71f02673e0d8293b344"

DESCRIPTION="A utility to report core memory usage per program"
HOMEPAGE="https://github.com/pixelb/ps_mem"
SRC_URI="https://github.com/pixelb/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

python_install() {
	distutils-r2_python_install --install-scripts="${EPREFIX}/usr/sbin"
}

python_install_all() {
	distutils-r2_python_install_all
	doman ${PN}.1
}
