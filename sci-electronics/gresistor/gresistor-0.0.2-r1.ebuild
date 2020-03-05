# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r2 eutils

DESCRIPTION="Translate a resistor color codes into a readable value"
HOMEPAGE="https://sourceforge.net/projects/gresistor/"
SRC_URI="mirror://sourceforge/gresistor/${P}.tar.gz"

LICENSE="|| ( GPL-3 LGPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	$(python_gen_cond_dep '
		dev-python/pygtk:2[${PYTHON_USEDEP}]
	')
	gnome-base/libglade:2.0[${PYTHON_SINGLE_USEDEP}]
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's/Version=0.0.2/Version=1.0/g' ${PN}.desktop || die
	distutils-r2_src_prepare
}

src_install() {
	distutils-r2_src_install
	python_domodule "${FILESDIR}/SimpleGladeApp.py"
	domenu ${PN}.desktop
}
