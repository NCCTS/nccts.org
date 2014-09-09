# DOCKER-VERSION 1.2.0, build fa7b24f

# Use ncct/baseimage as base image.
FROM nccts/baseimage:0.0.7

# Set correct environment variables.
ENV HOME /root

# Use phusion/baseimage's init system.
CMD ["/sbin/my_init"]

# Traffice Server
RUN apt-get update
RUN apt-get install -y python-sphinx autoconf automake autotools-dev bison debhelper dh-apparmor flex gettext intltool-debian libbison-dev libcap-dev libexpat1-dev libfl-dev libpcre3-dev libpcrecpp0 libsigsegv2 libsqlite3-dev libssl-dev libtool m4 po-debconf tcl-dev tcl8.6-dev zlib1g-dev libboost-dev libboost1.54-dev lua5.1 libxml2-dev liblua5.1-0-dev libhwloc-dev libhwloc-plugins libhwloc5 libpci-dev libcunit1-dev libevent-dev
RUN ldconfig

# SPDY
USER sailor
WORKDIR /home/sailor
ENV HOME /home/sailor
RUN mkdir Downloads
RUN cd Downloads && git clone https://github.com/tatsuhiro-t/spdylay.git
RUN cd Downloads/spdylay && git checkout v1.2.5 && autoreconf -i && automake && autoconf && ./configure && make
USER root
WORKDIR /
ENV HOME /root
RUN cd /home/sailor/Downloads/spdylay && make install
RUN ldconfig

# Traffic Server
USER sailor
WORKDIR /home/sailor
ENV HOME /home/sailor
RUN cd Downloads && git clone https://github.com/apache/trafficserver.git
# --disable-hwloc is necessary to build 4.x, but don't need that flag for 5.x builds
RUN cd Downloads/trafficserver && git checkout 44afb44869effcacdbdd622a38bdbc844062b7f5 && autoreconf -if && ./configure --with-user=www-data --enable-spdy && make
RUN cd Downloads/trafficserver && make check
USER root
WORKDIR /
ENV HOME /root
RUN cd /home/sailor/Downloads/trafficserver && make install
RUN ldconfig
RUN cd /usr/local && bin/traffic_server -R 1
RUN mkdir /etc/service/trafficserver
ADD traffic.sh /etc/service/trafficserver/run
USER sailor
USER root

# Cleanup downloads
RUN rm -rf /home/sailor/Downloads

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
