# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit cmake flag-o-matic llvm llvm.org python-any-r1 toolchain-funcs

DESCRIPTION="The LLVM linker (link editor)"
HOMEPAGE="https://llvm.org/"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA"
SLOT="${LLVM_MAJOR}/${LLVM_SOABI}"
KEYWORDS="amd64 arm arm64 ~ppc ppc64 ~riscv x86"
IUSE="debug test"
RESTRICT="!test? ( test )"

DEPEND="
	~llvm-core/llvm-${PV}
	sys-libs/zlib:=
"
RDEPEND="
	${DEPEND}
	!llvm-core/lld:0
"
BDEPEND="
	llvm-core/llvm:${LLVM_MAJOR}
	test? (
		$(python_gen_any_dep ">=dev-python/lit-${PV}[\${PYTHON_USEDEP}]")
	)
"
PDEPEND="
	>=llvm-core/lld-toolchain-symlinks-15-r2:${LLVM_MAJOR}
"

LLVM_COMPONENTS=( lld cmake libunwind/include/mach-o )
LLVM_TEST_COMPONENTS=( llvm/utils/{lit,unittest} )
LLVM_PATCHSET=16.0.6-r1
llvm.org_set_globals

python_check_deps() {
	python_has_version ">=dev-python/lit-${PV}[${PYTHON_USEDEP}]"
}

pkg_setup() {
	LLVM_MAX_SLOT=${LLVM_MAJOR} llvm_pkg_setup
	use test && python-any-r1_pkg_setup
}

src_unpack() {
	llvm.org_src_unpack

	# Directory ${WORKDIR}/llvm does not exist with USE="-test",
	# but LLVM_MAIN_SRC_DIR="${WORKDIR}/llvm" is set below,
	# and ${LLVM_MAIN_SRC_DIR}/../libunwind/include is used by build system
	# (lld/MachO/CMakeLists.txt) and is expected to be resolvable
	# to existent directory ${WORKDIR}/libunwind/include.
	mkdir -p "${WORKDIR}/llvm" || die
}

src_configure() {
	# LLVM_ENABLE_ASSERTIONS=NO does not guarantee this for us, #614844
	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"

	use elibc_musl && append-ldflags -Wl,-z,stack-size=2097152

	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/${LLVM_MAJOR}"
		-DBUILD_SHARED_LIBS=ON
		-DLLVM_INCLUDE_TESTS=$(usex test)
		-DLLVM_MAIN_SRC_DIR="${WORKDIR}/llvm"
		-DLLVM_ENABLE_ZLIB=FORCE_ON
	)

	use test && mycmakeargs+=(
		-DLLVM_BUILD_TESTS=ON
		-DLLVM_EXTERNAL_LIT="${EPREFIX}/usr/bin/lit"
		-DLLVM_LIT_ARGS="$(get_lit_flags)"
		-DPython3_EXECUTABLE="${PYTHON}"
	)

	tc-is-cross-compiler &&	mycmakeargs+=(
		-DLLVM_TABLEGEN_EXE="${BROOT}/usr/lib/llvm/${LLVM_MAJOR}/bin/llvm-tblgen"
	)

	cmake_src_configure
}

src_test() {
	local -x LIT_PRESERVES_TMP=1
	cmake_build check-lld
}
