#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export HOME=/root

# Install Traffic Server run script
mkdir -p /etc/service/trafficserver
cp /docker-build/support/traffic.sh /etc/service/trafficserver/run

# Install packages
apt-get update
apt-get install -y autoconf automake autotools-dev bison debhelper dh-apparmor dpkg-dev flex g++ gcc gettext intltool-debian libbison-dev libboost-dev libboost1.54-dev libc6-dev libcap-dev libcunit1-dev libevent-dev libexpat1-dev libfl-dev libhwloc-dev libhwloc-plugins libhwloc5 liblua5.1-0-dev libpci-dev libpcre3-dev libpcrecpp0 liblzma-dev libsigsegv2 libsqlite3-dev libssl-dev libtool libxml2-dev lua5.1 m4 make pkg-config po-debconf python-sphinx software-properties-common tcl-dev tcl8.6-dev zlib1g-dev

# Build and install: spdylay
cd /docker-build/support
git clone https://github.com/tatsuhiro-t/spdylay.git
cd spdylay
git checkout v1.3.1
autoreconf -i
automake
autoconf
./configure
make
make install

# Build and install: Traffic Server
cd /docker-build/support
git clone https://github.com/apache/trafficserver.git
# # --disable-hwloc is necessary to build 4.x, but don't need that flag for 5.x builds
cd trafficserver
git checkout 44afb44869effcacdbdd622a38bdbc844062b7f5
autoreconf -if
./configure --with-user=www-data --enable-spdy
make
make check
make install
cd /usr/local
bin/traffic_server -R 1

# Cleanup
# THE FOLLOWING 'remove' LIST NEEDS REVISION
apt-get -y remove --auto-remove autoconf automake dpkg-dev g++ gcc libc6-dev libpcre3-dev liblzma-dev pkg-config software-properties-common zlib1g-dev
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# What's going on with traffic server
# see: https://wiki.ubuntu.com/Strace
# apt-get install -y strace
# as root, and with docker container running in --privileged mode:
# strace -Ff -tt -p <[ET_NET 0] PID> 2>&1 | tee strace-trafficserver-ET_NET_0.log
# "paste" log to internet
# curl --data-binary @trafficserver.log http://curl-paste.com
# high CPU utilization is probably related to:
# http://permalink.gmane.org/gmane.comp.apache.trafficserver.devel/1883
# some helpful slides (open w/ webkit browser):
# http://labs.omniti.com/people/mark/ats_sa/slides.html#slide-0

# can bring SPDY into the picture:
# https://github.com/tatsuhiro-t/spdylay
# https://issues.apache.org/jira/browse/TS-2431
# need to double-check build deps
