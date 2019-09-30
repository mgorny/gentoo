# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools toolchain-funcs

MY_P=${P/editor}

DESCRIPTION="A file viewer, editor and analyzer for text, binary, and executable files"
HOMEPAGE="http://hte.sourceforge.net/ https://github.com/sebastianbiallas/ht/"
SRC_URI="https://download.sourceforge.net/hte/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="X"

RDEPEND="sys-libs/ncurses:0=
	X? ( x11-libs/libX11 )
	>=dev-libs/lzo-2"
DEPEND="${RDEPEND}
	virtual/yacc
	sys-devel/flex"

DOCS=( AUTHORS ChangeLog KNOWNBUGS README TODO )

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}"/${P}-gcc-7.patch
	"${FILESDIR}"/${P}-tinfo.patch
	"${FILESDIR}"/${P}-gcc-6-uchar.patch
	"${FILESDIR}"/${P}-format-security.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable X x11-textmode) \
		--enable-maintainermode
}

src_compile() {
	emake AR="$(tc-getAR)" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	#For prefix
	chmod u+x "${S}/install-sh"

	local HTML_DOCS="doc/*.html"
	doinfo doc/*.info

	default
}
