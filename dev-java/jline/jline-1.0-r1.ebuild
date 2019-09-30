# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Handle console input in Java"
HOMEPAGE="http://jline.sourceforge.net/"
SRC_URI="https://download.sourceforge.net/${PN}/${P}.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

DEPEND="
	>=virtual/jdk-1.6
	app-arch/unzip
	test? (
		dev-java/ant-junit:0
		dev-java/junit:0
	)"

RDEPEND="
	>=virtual/jre-1.6"

S="${WORKDIR}/${P}/src"

src_prepare() {
	default
	java-pkg_clean

	# we don't support maven for building yet.
	# this build.xml was generated by:
	# - mvn ant:ant
	# - tweak build.xml to not load properties from home dir
	# - tweak the test target to match the test cases
	# - change maven.repo.local from ~/.maven to "lib" in .properties
	# - change classpath definitions to "*.jar"

	cp "${FILESDIR}/maven-build.xml" build.xml || die
	cp "${FILESDIR}/maven-build.properties" . || die
	java-ant_ignore-system-classes

	mkdir lib || die
	cd lib || die
	if use test; then
		java-pkg_jar-from --build-only junit
	fi
}

src_compile() {
	# precompiled javadocs (needs maven to generate)
	# -Dmaven.build.finalName is needed to override the one defined in the
	# build.xml, which because it was generated with 0.9.9, defaults to
	# jline-0.9.9 -nichoj
	eant package -Dmaven.build.finalName=${P}
}

src_test() {
	ANT_TASKS="ant-junit" eant test -Djunit.present=true
}

src_install() {
	java-pkg_newjar target/${P}.jar
	# no api docs in this release
	# use doc && java-pkg_dojavadoc ../apidocs
	use source && java-pkg_dosrc src/main/java
}
