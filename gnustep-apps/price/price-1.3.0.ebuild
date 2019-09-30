# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnustep-2

MY_P=PRICE-${PV}
DESCRIPTION="Precision Raster Image Convolution Engine"
HOMEPAGE="http://price.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/price/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=gnustep-base/gnustep-gui-0.13.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
