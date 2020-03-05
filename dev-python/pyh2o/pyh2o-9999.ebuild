# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_6 )

inherit distutils-r2 git-r3

DESCRIPTION="Python API for sci-libs/libh2o"
HOMEPAGE="https://github.com/mgorny/pyh2o/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mgorny/pyh2o.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=sci-libs/libh2o-0.2.1:="
DEPEND="${RDEPEND}"
