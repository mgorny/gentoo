# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	libc@0.2.172
"

inherit cargo

DESCRIPTION="zlib rewrite in Rust"
HOMEPAGE="https://github.com/trifectatechfoundation/zlib-rs/"
SRC_URI="
	https://github.com/trifectatechfoundation/zlib-rs/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"
S=${WORKDIR}/${P}/libz-rs-sys-cdylib

LICENSE="ZLIB"
# Dependent crate licenses
LICENSE+=" || ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-util/cargo-c
"

call_cargo() {
	local cmd=(
		cargo "${@}"
		--target-dir="capi"
		--prefix="${EPREFIX}/usr"
		--libdir="${EPREFIX}/usr/$(get_libdir)"
	)
	if ! use debug; then
		cmd+=( --release )
	fi

	echo "${cmd[*]}" >&2
	"${cmd[@]}" || die "cargo-c failed"
}

src_prepare() {
	cargo_src_prepare

	# build as libz.so
	sed -i -e 's:
}

src_compile() {
	: # delay building into src_install, since src_test() will overwrite it
}

src_test() {
	call_cargo ctest --features=gz,__internal-test
}

src_install() {
	call_cargo cinstall --features=gz --library-type=cdylib --destdir="${D}"
}
