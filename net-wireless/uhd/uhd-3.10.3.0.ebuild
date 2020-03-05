# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit versionator python-single-r2 gnome2-utils cmake-utils multilib

DESCRIPTION="Universal Software Radio Peripheral (USRP) Hardware Driver"
HOMEPAGE="http://code.ettus.com/redmine/ettus/projects/uhd/wiki"

image_version=uhd-images_00$(get_version_component_range 1).0$(get_version_component_range 2).00$(get_version_component_range 3).00$(get_version_component_range 4)-release
SRC_URI="https://github.com/EttusResearch/uhd/archive/release_00$(get_version_component_range 1)_0$(get_version_component_range 2)_00$(get_version_component_range 3)_00$(get_version_component_range 4).tar.gz -> EttusResearch-UHD-$(get_version_component_range 1).$(get_version_component_range 2).$(get_version_component_range 3).$(get_version_component_range 4).tar.gz \
	http://files.ettus.com/binaries/images/${image_version}.zip"
#https://github.com/EttusResearch/UHD-Mirror/tags
#http://files.ettus.com/binaries/images/

LICENSE="GPL-3"
SLOT="0/1"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	virtual/libusb:1
	dev-lang/orc
	dev-libs/boost:=
	sys-libs/ncurses:0[tinfo]
"

DEPEND="${RDEPEND}
	dev-python/mako
	dev-python/cheetah
	app-arch/unzip
"

PATCHES=( "${FILESDIR}/${P}-tinfo.patch" )

S="${WORKDIR}"/uhd-release_00$(get_version_component_range 1)_0$(get_version_component_range 2)_00$(get_version_component_range 3)_00$(get_version_component_range 4)/host

src_prepare() {
	cmake-utils_src_prepare

	gnome2_environment_reset #534582

	#this may not be needed in 3.4.3 and above, please verify
	sed -i 's#SET(PKG_LIB_DIR ${PKG_DATA_DIR})#SET(PKG_LIB_DIR ${LIBRARY_DIR}/uhd)#g' CMakeLists.txt || die
}

src_install() {
	cmake-utils_src_install
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/utils/
	insinto /lib/udev/rules.d/
	doins "${S}"/utils/uhd-usrp.rules
	insinto /usr/share/${PN}
	doins -r "${WORKDIR}"/"${image_version}"/share/uhd/images
}
