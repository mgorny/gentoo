# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Combinators and extra features for Par monads"
HOMEPAGE="https://github.com/simonmar/monad-par"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/abstract-par-0.3*:=[profile?]
		>=dev-haskell/cereal-0.3:=[profile?]
		>=dev-haskell/mtl-2.0:=[profile?]
		>=dev-haskell/random-1.0:=[profile?]
		>=dev-haskell/transformers-0.2:=[profile?]
		>=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8"
