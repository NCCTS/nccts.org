#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export HOME=/root

# Install packages
apt-get update
apt-get -y install autoconf automake curl dpkg-dev emacs24-nox g++ gcc git-core libc6-dev libpcre3-dev liblzma-dev make man-db pkg-config software-properties-common wget zlib1g-dev

# Locale
locale-gen --purge en_US.UTF-8
cat /docker-build/support/default_locale.txt > /etc/default/locale

# Settings for root
/docker-build/support/user_root.sh
/docker-build/support/user_common.sh

# Unprivileged user 'sailor'
adduser --disabled-password --gecos "" sailor
sudo -i -u sailor /docker-build/support/user_sailor.sh
sudo -i -u sailor /docker-build/support/user_common.sh

# Build, install: tmux
/docker-build/support/install_tmux.sh

# Build: ag, watchman
sudo -i -u sailor /docker-build/support/build_ag.sh
sudo -i -u sailor /docker-build/support/build_watchman.sh

# Install: ag, watchman
/docker-build/support/install_ag.sh
/docker-build/support/install_watchman.sh

# Cleanup
apt-get -y remove --auto-remove autoconf automake dpkg-dev g++ gcc libc6-dev libpcre3-dev liblzma-dev pkg-config software-properties-common zlib1g-dev
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
