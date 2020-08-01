# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Task scheduling and blocked algorithms for parallel processing"
HOMEPAGE="https://dask.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="distributed"

RDEPEND="
	>=dev-python/cloudpickle-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/fsspec-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.23.4[${PYTHON_USEDEP}]
	>=dev-python/partd-0.3.10[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/toolz-0.8.2[${PYTHON_USEDEP}]
	distributed? (
		>=dev-python/distributed-2.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="
	dev-python/toolz[${PYTHON_USEDEP}]
	test? (
		dev-python/numexpr[${PYTHON_USEDEP}]
		>=dev-python/s3fs-0.0.8[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	return

	# don't die on warnings or xpass
	sed -i -e '/error:::/d' -e '/xfail_strict/d' setup.cfg || die
	# new pandas
	sed -e 's:test_value_counts_with_dropna:_&:' \
		-e 's:test_to_timestamp:_&:' \
		-e 's:test_first_and_last:_&:' \
		-i dask/dataframe/tests/test_dataframe.py || die
	sed -e 's:test_reduction:_&:' \
		-i dask/dataframe/tests/test_extensions.py || die
	sed -e 's:test_loc_timestamp_str:_&:' \
		-i dask/dataframe/tests/test_indexing.py || die
	sed -e 's:test_set_index_on_empty:_&:' \
		-e 's:test_set_index_timestamp:_&:' \
		-i dask/dataframe/tests/test_shuffle.py || die
	sed -e 's:test_meta_nonempty:_&:' \
		-i dask/dataframe/tests/test_utils_dataframe.py || die
	sed -e 's:test_series_resample_non_existent_datetime:_&:' \
		-i dask/dataframe/tseries/tests/test_resample.py || die

	distutils-r1_src_prepare
}

python_test() {
	pytest -vv -m "not network" ||
		die "Tests failed with ${EPYTHON}"
}
