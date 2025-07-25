# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="tools for communicating with HackRF SDR platform"
HOMEPAGE="http://greatscottgadgets.com/hackrf/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/greatscottgadgets/hackrf.git"
	inherit git-r3
	EGIT_CHECKOUT_DIR="${WORKDIR}/hackrf"
	S="${WORKDIR}/hackrf/host/hackrf-tools"
else
	S="${WORKDIR}/hackrf-${PV}/host/hackrf-tools"
	SRC_URI="https://github.com/greatscottgadgets/hackrf/releases/download/v${PV}/hackrf-${PV}.tar.xz"
	KEYWORDS="~amd64 ~arm ~ppc ~x86"
fi

LICENSE="BSD"
SLOT="0"

DEPEND="~net-libs/libhackrf-${PV}:=
		sci-libs/fftw:3.0="
RDEPEND="${DEPEND}"

# Fix build with cmake4 i
# (see https://github.com/greatscottgadgets/hackrf/pull/1514)
src_prepare() {
	sed -i -e "s/2.8.12/3.8/" CMakeLists.txt || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	newsbin "${FILESDIR}/hackrf_easy_flash-r1" hackrf_easy_flash
	if [[ ${PV} != "9999" ]] ; then
		insinto /usr/share/hackrf
		newins "${WORKDIR}/hackrf-${PV}/firmware-bin/hackrf_jawbreaker_usb.bin" hackrf_jawbreaker_usb-${PV}.bin
		newins "${WORKDIR}/hackrf-${PV}/firmware-bin/hackrf_jawbreaker_usb.dfu" hackrf_jawbreaker_usb-${PV}.dfu
		newins "${WORKDIR}/hackrf-${PV}/firmware-bin/hackrf_one_usb.bin" hackrf_one_usb-${PV}.bin
		newins "${WORKDIR}/hackrf-${PV}/firmware-bin/hackrf_one_usb.dfu" hackrf_one_usb-${PV}.dfu
		newins "${WORKDIR}/hackrf-${PV}/firmware/cpld/sgpio_if/default.xsvf" hackrf_cpld_default-${PV}.xsvf
		ln -s hackrf_one_usb-${PV}.bin "${ED}/usr/share/hackrf/hackrf_one_usb_rom_to_ram.bin"
		ln -s hackrf_one_usb-${PV}.bin "${ED}/usr/share/hackrf/hackrf_one_usb.bin"
		ln -s hackrf_one_usb-${PV}.dfu "${ED}/usr/share/hackrf/hackrf_one_usb_ram.dfu"
		ln -s hackrf_one_usb-${PV}.dfu "${ED}/usr/share/hackrf/hackrf_one_usb.dfu"
	else
		ewarn "The compiled firmware files are only available in the versioned releases, you are on your own for this."
		ewarn "A hackrf-firmware ebuild is available in the pentoo overlay, if you feel adventurous."
	fi
}
