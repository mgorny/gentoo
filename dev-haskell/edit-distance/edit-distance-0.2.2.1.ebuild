# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Levenshtein and restricted Damerau-Levenshtein edit distances"
HOMEPAGE="https://github.com/phadej/edit-distance"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

RDEPEND=">=dev-haskell/random-1.0:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/quickcheck-2.4 <dev-haskell/quickcheck-2.9
		>=dev-haskell/test-framework-0.1.1
		dev-haskell/test-framework-quickcheck2 )
"
