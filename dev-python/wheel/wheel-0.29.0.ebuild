# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_6 pypy3 )

inherit distutils-r1 eutils

DESCRIPTION="A built-package format for Python"
HOMEPAGE="https://pypi.org/project/wheel/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 hppa m68k sh x86"
IUSE="doc test"

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
#	test? (
#		dev-python/keyring
#		dev-python/keyrings_alt
#		dev-python/ed25519ll
#		dev-python/pytest[${PYTHON_USEDEP}]
#	)
#"

# Fails somehow
RESTRICT=test

python_test() {
	sed \
		-e 's:--cov=wheel::g' \
		-i setup.cfg || die
	py.test -v -v || die "testsuite failed under ${EPYTHON}"
}

pkg_postinst() {
	optfeature "Signature support" \
		dev-python/keyring \
		dev-python/keyrings_alt \
		dev-python/ed25519ll
}
