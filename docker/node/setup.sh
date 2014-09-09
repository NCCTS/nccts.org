#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export HOME=/root

# Setup nvm / Node.js for unprivileged user 'sailor'
sudo -i -u sailor /docker-build/support/user_sailor.sh

# Cleanup
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
