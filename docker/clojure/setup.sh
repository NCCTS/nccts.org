#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export HOME=/root

# Install packages
apt-get update
apt-get -y install software-properties-common
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install -y oracle-java7-installer

# Setup Leiningen / Clojure environment for unprivileged user 'sailor'
sudo -i -u sailor /docker-build/support/user_sailor.sh

# Cleanup
apt-get -y remove --auto-remove software-properties-common
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
