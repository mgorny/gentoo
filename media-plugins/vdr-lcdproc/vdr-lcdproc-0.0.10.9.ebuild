# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vdr-plugin-2 versionator

VERSION="932" # every bump, new version

MY_P=${PN}-$(replace_version_separator 3 -jw ${PV})

DESCRIPTION="VDR plugin: use LCD device for additional output"
HOMEPAGE="https://projects.vdr-developer.org/projects/plg-lcdproc"
SRC_URI="https://projects.vdr-developer.org/attachments/download/${VERSION}/${MY_P}.tgz -> ${P}.tgz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6
		>=app-misc/lcdproc-0.4.3"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P#vdr-}
