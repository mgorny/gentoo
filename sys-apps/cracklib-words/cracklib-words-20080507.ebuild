# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=0

DESCRIPTION="large set of crack/cracklib dictionaries"
HOMEPAGE="https://sourceforge.net/projects/cracklib"
SRC_URI="https://download.sourceforge.net/cracklib/${P}.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_install() {
	insinto /usr/share/dict
	newins ${P} ${PN} || die
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] && type create-cracklib-dict >/dev/null ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict /usr/share/dict/* > /dev/null
		eend $?
	fi
}
