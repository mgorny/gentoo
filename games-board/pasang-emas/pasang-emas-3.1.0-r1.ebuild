# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils gnome2-utils

DESCRIPTION="A traditional game of Brunei"
HOMEPAGE="http://pasang-emas.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/${PN}/${P}.tar.bz2
	extras? ( https://download.sourceforge.net/${PN}/pasang-emas-themes-1.0.tar.bz2
	          https://download.sourceforge.net/${PN}/pet-marble.tar.bz2
	          https://download.sourceforge.net/${PN}/pet-fragrance.tar.bz2 )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extras nls"

RDEPEND="app-text/gnome-doc-utils
	>=x11-libs/gtk+-2.18.2:2
	virtual/libintl"
DEPEND="${RDEPEND}
	app-text/rarian
	nls? ( sys-devel/gettext )"

PATCHES=(
	"${FILESDIR}"/${P}-build.patch
)

src_prepare() {
	default
	sed -i \
		-e '/Encoding/d' \
		-e '/Icon/s:\.png::' \
		data/pasang-emas.desktop.in || die
	gnome2_omf_fix
}

src_configure() {
	econf \
		--localedir=/usr/share/locale \
		--with-omf-dir=/usr/share/omf \
		--with-help-dir=/usr/share/gnome/help \
		$(use_enable nls)
}

src_install() {
	default
	if use extras; then
		insinto /usr/share/${PN}/themes
		doins -r \
			"${WORKDIR}"/marble \
			"${WORKDIR}"/pasang-emas-themes-1.0/{conteng,kaca} \
			"${WORKDIR}"/fragrance
	fi
	use nls || rm -rf "${D}"usr/share/locale
}

pkg_preinst() {
	gnome2_scrollkeeper_savelist
}

pkg_postinst() {
	gnome2_scrollkeeper_update
}

pkg_postrm() {
	gnome2_scrollkeeper_update
}
