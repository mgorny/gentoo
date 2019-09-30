# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils flag-o-matic gnome2-utils

DESCRIPTION="FreeDoko is a Doppelkopf-game"
HOMEPAGE="http://free-doko.sourceforge.net"
SRC_URI="https://download.sourceforge.net/free-doko/FreeDoko_${PV}.src.zip
	backgrounds? ( https://download.sourceforge.net/free-doko/backgrounds.zip -> ${PN}-backgrounds.zip )
	kdecards? ( https://download.sourceforge.net/free-doko/kdecarddecks.zip )
	xskatcards? ( https://download.sourceforge.net/free-doko/xskat.zip )
	pysolcards? ( https://download.sourceforge.net/free-doko/pysol.zip )
	gnomecards? ( https://download.sourceforge.net/free-doko/gnome-games.zip )
	openclipartcards? ( https://download.sourceforge.net/free-doko/openclipart.zip )
	!xskatcards? (
		!kdecards? (
			!gnomecards? (
				!openclipartcards? (
					!pysolcards? (
						https://download.sourceforge.net/free-doko/xskat.zip ) ) ) ) )"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+xskatcards +gnomecards +kdecards +openclipartcards +pysolcards +backgrounds"

RDEPEND=">=dev-cpp/gtkmm-2.4:2.4"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig"

S=${WORKDIR}/FreeDoko_${PV}

src_unpack() {
	local cards=0

	unpack_cards() {
		use $1 && { unpack $2 ; cards=$(( $cards + 1 )); };
	}
	unpack FreeDoko_${PV}.src.zip
	cp /dev/null "${S}"/src/Makefile.local || die

	cd "${S}"/data/cardsets || die

	unpack_cards xskatcards       xskat.zip
	unpack_cards kdecards         kdecarddecks.zip
	unpack_cards pysolcards       pysol.zip
	unpack_cards gnomecards       gnome-games.zip
	unpack_cards openclipartcards openclipart.zip
	[ $cards ] || unpack xskat.zip # fall back to xskat

	if use backgrounds ; then
		cd "${S}"/data/backgrounds || die
		unpack ${PN}-backgrounds.zip
	fi
}

PATCHES=(
	"${FILESDIR}"/${PN}-0.7.16-gentoo.patch
)

src_prepare() {
	default
	export VARTEXFONTS="${T}/fonts" #652028
	append-cxxflags -std=c++14
}

src_compile() {
	export CPPFLAGS="-DPUBLIC_DATA_DIRECTORY_VALUE='\"/usr/share/${PN}\"'"
	export CPPFLAGS+=" -DMANUAL_DIRECTORY_VALUE='\"/usr/share/doc/${PF}/html\"'"
	export OSTYPE=Linux
	export USE_NETWORK=false
	export USE_SOUND_ALUT=false # still marked experimental
	emake Version
	emake -C src FreeDoko
}

src_install() {
	newbin src/FreeDoko freedoko
	insinto /usr/share/${PN}/
	doins -r data/{backgrounds,cardsets,iconsets,rules,sounds,translations,*png}
	find "${D}/usr/share/${PN}" -name Makefile -delete
	dodoc AUTHORS README ChangeLog
	newicon -s 32 src/FreeDoko.png ${PN}.png
	make_desktop_entry ${PN} FreeDoko
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
