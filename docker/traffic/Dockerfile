# DOCKER-VERSION 0.12.0

# Use ncct/baseimage as base image.
FROM nccts/baseimage:0.0.1

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Traffice Server
RUN apt-get update
RUN apt-get install -y wget autoconf automake autotools-dev bison debhelper dh-apparmor flex gettext intltool-debian libbison-dev libcap-dev libexpat1-dev libfl-dev libpcre3-dev libpcrecpp0 libsigsegv2 libsqlite3-dev libssl-dev libtool m4 po-debconf tcl-dev tcl8.6-dev zlib1g-dev libboost-dev libboost1.54-dev lua5.1 libxml2-dev liblua5.1-0-dev libhwloc-dev libhwloc-plugins libhwloc5 libpci-dev
USER nccts
WORKDIR /home/nccts
ENV HOME /home/nccts
RUN mkdir Downloads && cd Downloads && git clone https://github.com/apache/trafficserver.git
RUN cd Downloads/trafficserver && git checkout 3ccf42e6a905d3ad1ed8aa76a74cfd67a3e5048d && autoreconf -if && ./configure --prefix=/opt/ats --with-user=www-data && make && make check
USER root
WORKDIR /
ENV HOME /root
RUN cd /home/nccts/Downloads/trafficserver && make install
RUN rm -rf /home/nccts/Downloads

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
