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
RUN apt-get install -y ca-certificates git-core software-properties-common tmux

# Unprivileged user
RUN adduser --disabled-password --gecos "" nccts
USER nccts
WORKDIR /home/nccts
ENV HOME /home/nccts
RUN printf "\nexport LC_ALL=en_US.UTF-8\nexport LANG=en_US.UTF-8\nexport LANGUAGE=en_US.UTF-8\n" >> .bashrc
USER root
WORKDIR /
ENV HOME /root

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
