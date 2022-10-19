# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
inherit cmake llvm llvm.org python-any-r1

DESCRIPTION="Multi-Level Intermediate Representation (library only)"
HOMEPAGE="https://mlir.llvm.org/"

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="${LLVM_MAJOR}/${LLVM_SOABI}"
KEYWORDS=""
IUSE="debug test"
RESTRICT="!test? ( test )"

DEPEND="
	~sys-devel/llvm-${PV}:${LLVM_MAJOR}=[debug=]
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	${PYTHON_DEPS}
	>=dev-util/cmake-3.16
"

LLVM_COMPONENTS=( mlir cmake )
LLVM_TEST_COMPONENTS=( llvm/{include,utils/unittest} )
llvm.org_set_globals

pkg_setup() {
	LLVM_MAX_SLOT=${LLVM_MAJOR} llvm_pkg_setup
	python-any-r1_pkg_setup
}

check_distribution_components() {
	if [[ ${CMAKE_MAKEFILE_GENERATOR} == ninja ]]; then
		local all_targets=() my_targets=() l
		cd "${BUILD_DIR}" || die

		while read -r l; do
			if [[ ${l} == install-*-stripped:* ]]; then
				l=${l#install-}
				l=${l%%-stripped*}

				case ${l} in
					# meta-targets
					mlir-libraries|distribution)
						continue
						;;
					# static libraries
					MLIR*)
						continue
						;;
				esac

				all_targets+=( "${l}" )
			fi
		done < <(${NINJA} -t targets all)

		while read -r l; do
			my_targets+=( "${l}" )
		done < <(get_distribution_components $"\n")

		local add=() remove=()
		for l in "${all_targets[@]}"; do
			if ! has "${l}" "${my_targets[@]}"; then
				add+=( "${l}" )
			fi
		done
		for l in "${my_targets[@]}"; do
			if ! has "${l}" "${all_targets[@]}"; then
				remove+=( "${l}" )
			fi
		done

		if [[ ${#add[@]} -gt 0 || ${#remove[@]} -gt 0 ]]; then
			eqawarn "get_distribution_components() is outdated!"
			eqawarn "   Add: ${add[*]}"
			eqawarn "Remove: ${remove[*]}"
		fi
		cd - >/dev/null || die
	fi
}

get_distribution_components() {
	local sep=${1-;}

	local out=(
		mlir-cmake-exports
		mlir-headers

		# shared libs
		MLIR-C
		#mlir_async_runtime
		#mlir_c_runner_utils
		#mlir_float16_utils
		#mlir_runner_utils

		# tools
		#mlir-cpu-runner
		#mlir-linalg-ods-yaml-gen
		#mlir-lsp-server
		#mlir-opt
		#mlir-pdll-lsp-server
		#mlir-reduce mlir-translate
		#tblgen-lsp-server

		# utilities
		#mlir-pdll
		mlir-tblgen
	)

	printf "%s${sep}" "${out[@]}"
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/${LLVM_MAJOR}"

		-DBUILD_SHARED_LIBS=OFF
		-DMLIR_BUILD_MLIR_C_DYLIB=ON
		-DMLIR_LINK_MLIR_DYLIB=ON
		-DMLIR_INCLUDE_TESTS=$(usex test)
		-DLLVM_DISTRIBUTION_COMPONENTS=$(get_distribution_components)
		# this enables installing mlir-tblgen and mlir-pdll
		-DLLVM_BUILD_UTILS=ON

		-DPython3_EXECUTABLE="${PYTHON}"

		# tools are skipped for now, until upstream updates dylib API
		# to allow dynamic linking, see:
		# https://discourse.llvm.org/t/trying-to-get-mlir-link-mlir-dylib-implemented/66086
		-DLLVM_BUILD_TOOLS=OFF
		-DMLIR_ENABLE_CUDA_RUNNER=OFF
		-DMLIR_ENABLE_ROCM_RUNNER=OFF
		-DMLIR_ENABLE_SPIRV_CPU_RUNNER=OFF
		-DMLIR_ENABLE_VULKAN_RUNNER=OFF
		-DMLIR_ENABLE_BINDINGS_PYTHON=OFF
		-DMLIR_INSTALL_AGGREGATE_OBJECTS=OFF
	)
	use test && mycmakeargs+=(
		-DLLVM_EXTERNAL_LIT="${EPREFIX}/usr/bin/lit"
		-DLLVM_LIT_ARGS="$(get_lit_flags)"
	)

	# LLVM_ENABLE_ASSERTIONS=NO does not guarantee this for us, #614844
	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake_src_configure

	# we currently don't install all available components
	#check_distribution_components
}

src_compile() {
	cmake_build distribution
}

src_test() {
	# respect TMPDIR!
	local -x LIT_PRESERVES_TMP=1
	cmake_build check-mlir
}

src_install() {
	DESTDIR=${D} cmake_build install-distribution
}
