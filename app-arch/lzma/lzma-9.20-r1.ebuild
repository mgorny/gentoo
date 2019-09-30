# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

MY_P="${PN}${PV//.}"
DESCRIPTION="LZMA Stream Compressor from the SDK"
HOMEPAGE="https://www.7-zip.org/sdk.html"
SRC_URI="https://download.sourceforge.net/sevenzip/${MY_P}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~mips ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc"

S=${WORKDIR}

src_compile() {
	cd CPP/7zip/Bundles/LzmaCon || die
	emake -f makefile.gcc \
		CXX="$(tc-getCXX) ${CXXFLAGS} ${CPPFLAGS}" \
		CXX_C="$(tc-getCC) ${CFLAGS} ${CPPFLAGS}"
}

src_install() {
	newbin CPP/7zip/Bundles/LzmaCon/lzma lzmacon || die
	dodoc lzma.txt history.txt
	use doc && dodoc 7zC.txt 7zFormat.txt Methods.txt
}

pkg_postinst() {
	einfo "The lzma binary is now 'lzmacon' to avoid xz-utils conflicts #218459"
}
