# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Compositional pipelines"
HOMEPAGE="https://hackage.haskell.org/package/pipes"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/mmorph-1.0.0:=[profile?] <dev-haskell/mmorph-1.1:=[profile?]
	>=dev-haskell/mtl-2.1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/transformers-0.2.0.0:=[profile?] <dev-haskell/transformers-0.6:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( >=dev-haskell/quickcheck-2.4 <dev-haskell/quickcheck-3
		>=dev-haskell/test-framework-0.4 <dev-haskell/test-framework-1
		>=dev-haskell/test-framework-quickcheck2-0.2.0 <dev-haskell/test-framework-quickcheck2-0.4 )
"
