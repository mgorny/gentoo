# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils gnome2-utils cmake-utils

DESCRIPTION="Tile-based, cross-platform 2D racing game"
HOMEPAGE="http://dustrac.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/dustrac/${P}.tar.gz"

LICENSE="GPL-3+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtopengl:5
	dev-qt/qtxml:5
	media-libs/libvorbis
	media-libs/openal
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	dev-qt/qttest:5
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-cmake.patch
)

src_configure() {
	# -DGLES=ON didn't build for me but maybe just need use flags on some QT package?
	# Maybe add a local gles use flag
	local mycmakeargs=(
		-DReleaseBuild=ON
		-DDATA_PATH="/usr/share/${PN}"
		-DBIN_PATH="/usr/bin"
		-DDOC_PATH=/usr/share/doc/${PF}
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	# FIXME: where should these come from?
	dosym /usr/share/fonts/ubuntu-font-family/UbuntuMono-B.ttf "/usr/share/${PN}/fonts/UbuntuMono-B.ttf"
	dosym /usr/share/fonts/ubuntu-font-family/UbuntuMono-R.ttf "/usr/share/${PN}/fonts/UbuntuMono-R.ttf"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
