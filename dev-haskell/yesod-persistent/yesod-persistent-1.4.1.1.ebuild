# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Some helpers for using Persistent from Yesod"
HOMEPAGE="https://www.yesodweb.com/"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/blaze-builder:=[profile?]
	dev-haskell/conduit:=[profile?]
	>=dev-haskell/persistent-2.1:=[profile?] <dev-haskell/persistent-2.7:=[profile?]
	>=dev-haskell/persistent-template-2.1:=[profile?] <dev-haskell/persistent-template-2.7:=[profile?]
	dev-haskell/resource-pool:=[profile?]
	>=dev-haskell/resourcet-0.4.5:=[profile?]
	>=dev-haskell/yesod-core-1.4.0:=[profile?] <dev-haskell/yesod-core-1.5:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( dev-haskell/hspec
		dev-haskell/persistent-sqlite
		dev-haskell/text
		dev-haskell/wai-extra )
"
