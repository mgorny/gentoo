# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

RUST_MIN_VERSION=1.78.0

inherit cargo

DESCRIPTION="Find your minimum supported Rust version (MSRV)!"
HOMEPAGE="
	https://gribnau.dev/cargo-msrv/
	https://github.com/foresterre/cargo-msrv/
	https://crates.io/crates/cargo-msrv/
"
SRC_URI="
	https://github.com/foresterre/cargo-msrv/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"
if [[ ${PKGBUMPING} != ${PVR} ]]; then
	SRC_URI+="
		https://dev.gentoo.org/~mgorny/dist/${P}-crates.tar.xz
	"
fi

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

src_test() {
	# these tests require random Rust/Cargo versions
	rm tests/{find,verify}_msrv.rs || die
	cargo_src_test --no-fail-fast
}
