# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gkrellm-plugin

DESCRIPTION="GKrellm plugin for monitoring bluetooth (Linux BlueZ) adapters"
SRC_URI="https://download.sourceforge.net/gkrellm-bluez/${P}.tar.gz"
HOMEPAGE="http://gkrellm-bluez.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	app-admin/gkrellm:2[X]
	net-wireless/bluez"
DEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-notheme.patch )

PLUGIN_SO=( src/.libs/gkrellmbluez$(get_modname) )
PLUGIN_DOCS=( THEMING NEWS )

src_prepare() {
	default
	# Be a bit more future proof, bug #260948
	sed "s/-Werror//" -i src/Makefile.am src/Makefile.in || die
}

src_configure() {
	econf --disable-static
}
