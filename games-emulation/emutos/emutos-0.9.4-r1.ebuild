# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Single-user single-tasking operating system for 32 bit Atari computer emulators"
HOMEPAGE="http://emutos.sourceforge.net"
SRC_URI="https://download.sourceforge.net/emutos/emutos-src-0.9.3.tar.gz
	https://download.sourceforge.net/emutos/emutos-512k-${PV}.zip
	https://download.sourceforge.net/emutos/emutos-256k-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	dolib */*.img
	dodoc emutos-512k-${PV}/{readme.txt,doc/{announce,authors,changelog,status}.txt}
}
