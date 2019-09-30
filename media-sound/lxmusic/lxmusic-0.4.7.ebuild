# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A simple GUI XMMS2 client with minimal functionality"
HOMEPAGE="https://wiki.lxde.org/en/LXMusic"
SRC_URI="https://download.sourceforge.net/lxde/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-sound/xmms2
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
