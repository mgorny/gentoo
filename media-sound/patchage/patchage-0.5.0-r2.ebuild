# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='threads(+)'

inherit flag-o-matic gnome2-utils waf-utils python-any-r2

DESCRIPTION="Modular patch bay for audio and MIDI systems"
HOMEPAGE="http://drobilla.net/software/patchage"
SRC_URI="http://download.drobilla.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa debug lash"

RDEPEND=">=media-libs/raul-0.7.0
	>=x11-libs/flowcanvas-0.7.1
	>=dev-cpp/gtkmm-2.11.12:2.4
	>=dev-cpp/glibmm-2.14:2
	>=dev-cpp/libglademm-2.6.0:2.4
	dev-cpp/libgnomecanvasmm:2.6
	virtual/jack
	alsa? ( media-libs/alsa-lib )
	lash? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-libs/boost
	virtual/pkgconfig"

DOCS=( AUTHORS README ChangeLog )

PATCHES=(
	"${FILESDIR}"/${P}-desktop.patch
)

src_configure() {
	append-cxxflags -std=c++11
	waf-utils_src_configure \
		$(use debug && echo "--debug") \
		$(use alsa || echo "--no-alsa") \
		$(use lash || echo "--no-lash")
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
