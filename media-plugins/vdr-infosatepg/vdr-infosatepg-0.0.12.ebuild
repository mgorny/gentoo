# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vdr-plugin-2

VERSION="1098" # every bump, new version!

DESCRIPTION="VDR Plugin: Reads the contents of infosat and writes the data into the EPG"
HOMEPAGE="https://projects.vdr-developer.org/projects/plg-infosatepg"
SRC_URI="https://projects.vdr-developer.org/attachments/download/${VERSION}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-2.0"
RDEPEND="${DEPEND}"
