# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=0

inherit eutils

DESCRIPTION="extract info or subtitles from DV stream"
HOMEPAGE="http://dv2sub.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/dv2sub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="kino"

DEPEND="media-libs/libdv"
RDEPEND="${DEPEND}
	kino? (
		media-video/kino
		media-video/dvdauthor
		virtual/ffmpeg
	)"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	if use kino; then
		insinto /usr/share/kino/scripts/exports
		exeinto /usr/share/kino/scripts/exports
		doins kino_scripts/dv2sub_spumux.xml
		doexe kino_scripts/*.sh
	fi
}
