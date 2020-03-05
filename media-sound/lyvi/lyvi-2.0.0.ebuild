# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python3_6 )

inherit distutils-r2

DESCRIPTION="A simple command-line lyrics viewer"
HOMEPAGE="http://ok100.github.io/lyvi/"
SRC_URI="https://github.com/ok100/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="WTFPL-2"
KEYWORDS="amd64"
SLOT="0"
IUSE="mpris"

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/plyr[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/urwid[${PYTHON_USEDEP}]
	mpris? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	)
"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Remove pip dependency
	sed -e '/require/d' --in-place setup.py || die
	distutils-r2_python_prepare_all
}
