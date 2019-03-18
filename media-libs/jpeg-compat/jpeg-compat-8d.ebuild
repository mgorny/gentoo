# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# this ebuild is only for the libjpeg.so.8 SONAME for ABI compat

inherit eutils libtool toolchain-funcs multilib-minimal

DESCRIPTION="Compatibility package for libjpeg.so.8"
HOMEPAGE="http://jpegclub.org/ http://www.ijg.org/"
SRC_URI="http://www.ijg.org/files/jpegsrc.v${PV}.tar.gz"

LICENSE="IJG"
SLOT="8"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="!=media-libs/jpeg-8*:0
	!<media-libs/libjpeg-turbo-1.3.0-r2"
DEPEND="${RDEPEND}"

DOCS=""

S=${WORKDIR}/jpeg-${PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/jpeg-7-maxmem_sysconf.patch \
		"${FILESDIR}"/jpeg-${PV}-CVE-2013-6629.patch
	elibtoolize
}

multilib_src_configure() {
	# Fix building against this library on eg. Solaris and DragonFly BSD, see:
	# http://mail-index.netbsd.org/pkgsrc-bugs/2010/01/18/msg035644.html
	local ldverscript=
	[[ ${CHOST} == *-solaris* ]] && ldverscript="--disable-ld-version-script"

	ECONF_SOURCE=${S} \
	econf \
		--disable-static \
		--enable-maxmem=64 \
		${ldverscript}
}

multilib_src_compile() {
	emake libjpeg.la
}

multilib_src_install() {
	newlib.so .libs/libjpeg.so.8.4.0 libjpeg.so.8
}
