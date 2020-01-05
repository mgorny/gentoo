# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

ROS_REPO_URI="https://github.com/ros/ros_comm"
KEYWORDS="~amd64 ~arm"
PYTHON_COMPAT=( python{2_7,3_6} pypy3 )
ROS_SUBDIR=tools/${PN}

inherit ros-catkin

DESCRIPTION="Prints information about the ROS Computation Graph"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/rospkg[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/mock[${PYTHON_USEDEP}] dev-python/nose[${PYTHON_USEDEP}] )"
PATCHES=( "${FILESDIR}/yaml.patch" "${FILESDIR}/py3.patch" "${FILESDIR}/py3-2.patch" )
