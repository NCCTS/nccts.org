# DOCKER-VERSION 0.12.0

# Use phusion/baseimage as base image.
FROM phusion/baseimage:0.9.10

# Set correct environment variables.
ENV HOME /root

# Disable sshd
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Locale
RUN locale-gen --purge en_US.UTF-8
RUN echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale
RUN printf "\nexport LC_ALL=en_US.UTF-8\nexport LANG=en_US.UTF-8\nexport LANGUAGE=en_US.UTF-8\n" >> /root/.bashrc

# Common tools
RUN apt-get update
RUN apt-get install -y autoconf automake build-essential ca-certificates curl git-core libpcre3-dev liblzma-dev man-db pkg-config software-properties-common tmux wget zlib1g-dev

# Unprivileged user
RUN adduser --disabled-password --gecos "" sailor
USER sailor
WORKDIR /home/sailor
ENV HOME /home/sailor
RUN printf "\nexport LC_ALL=en_US.UTF-8\nexport LANG=en_US.UTF-8\nexport LANGUAGE=en_US.UTF-8\n" >> .bashrc

# Build and install: watchman, ag
RUN mkdir Downloads && cd Downloads && git clone https://github.com/facebook/watchman.git
RUN cd Downloads/watchman && git checkout v2.9.8 && ./autogen.sh && ./configure && make
RUN cd Downloads && git clone https://github.com/ggreer/the_silver_searcher.git
RUN cd Downloads/the_silver_searcher && git checkout 0.22.0 && ./build.sh
USER root
WORKDIR /
ENV HOME /root
RUN cd /home/sailor/Downloads/watchman && make install
RUN cd /home/sailor/Downloads/the_silver_searcher && make install
RUN rm -rf /home/sailor/Downloads

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
