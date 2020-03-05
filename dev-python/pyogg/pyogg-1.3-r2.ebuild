# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r2 toolchain-funcs

DESCRIPTION="Python bindings for the ogg library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
# Grumble. They changed the tarball without changing the name..
#SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}-r1.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/libogg-1.0"
RDEPEND="${DEPEND}"

DOCS=( COPYING ChangeLog )

python_configure_all() {
	tc-export CC
	"${PYTHON}" config_unix.py --prefix /usr || die "Configuration failed"
}

python_install_all() {
	distutils-r2_python_install_all
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}
