# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# this ebuild is only for the libjpeg.so.62 SONAME for ABI compat

PATCH_VER=1
inherit eutils libtool toolchain-funcs multilib-minimal

DESCRIPTION="Compatibility package for libjpeg.so.62"
HOMEPAGE="http://www.ijg.org/"
SRC_URI="mirror://gentoo/jpegsrc.v${PV}.tar.gz
	https://dev.gentoo.org/~ssuominen/jpeg-${PV}-patchset-${PATCH_VER}.tar.xz"

LICENSE="IJG"
SLOT="62"
KEYWORDS="~alpha amd64 ~arm arm64 ~hppa ~ia64 m68k ~mips ~ppc ~ppc64 s390 sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

DOCS=""

RDEPEND="!>=media-libs/libjpeg-turbo-1.3.0-r2:0"
DEPEND="${RDEPEND}"

S=${WORKDIR}/jpeg-${PV}

src_prepare() {
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	epatch "${FILESDIR}"/jpeg-8d-CVE-2013-6629.patch
	elibtoolize
}

multilib_src_configure() {
	tc-export CC
	ECONF_SOURCE=${S} \
	econf \
		--enable-shared \
		--disable-static \
		--enable-maxmem=64
}

multilib_src_compile() {
	emake libjpeg.la
}

multilib_src_install() {
	newlib.so .libs/libjpeg.so.62.0.0 libjpeg.so.62
}
