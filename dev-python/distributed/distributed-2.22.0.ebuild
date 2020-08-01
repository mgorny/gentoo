# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Python library for distributed computation"
HOMEPAGE="https://distributed.readthedocs.io/en/latest/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	>=dev-python/click-6.6[${PYTHON_USEDEP}]
	>=dev-python/cloudpickle-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/dask-2.9.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.0[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/tblib-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/toolz-0.8.2[${PYTHON_USEDEP}]
	>=dev-python/zict-0.1.3[${PYTHON_USEDEP}]
	>=www-servers/tornado-6.0.3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/${P}-test.patch
)

src_prepare() {
	# ipv6-based tests fail in network sandbox
	sed -i -e 's:has_ipv6():False:' \
		distributed/comm/tests/test_comms.py \
		distributed/tests/test_core.py || die
	# network
	sed -e 's:test_defaults:_&:' \
		-e 's:test_hostport:_&:' \
		-i distributed/cli/tests/test_dask_scheduler.py || die

	distutils-r1_src_prepare
}

python_test() {
	distutils_install_for_testing
	local -x PATH=${TEST_DIR}/scripts:${PATH}
	pytest -xl -vv -m "not avoid_travis" ||
		die "Tests failed with ${EPYTHON}"
}
