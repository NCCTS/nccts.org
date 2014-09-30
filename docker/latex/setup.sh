#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export HOME=/root

# Install packages
apt-get update
apt-get -y install autoconf automake dpkg-dev g++ gcc imagemagick libc6-dev libdb5.3-dev libgdbm-dev libxslt1-dev make perl-doc perlmagick poppler-utils software-properties-common zlib1g-dev

# Setup LaTeX environment as unprivileged user 'sailor'
mkdir -p /usr/local/texlive
chmod -R 777 /usr/local/texlive/
sudo -i -u sailor /docker-build/support/user_sailor.sh

export PATH=/usr/local/texlive/2014/bin/x86_64-linux:$PATH

# Build and install: LaTeXML
cpan Archive::Zip DB_File File::Which Image::Size IO::String JSON::XS LWP Parse::RecDescent URI XML::LibXML XML::LibXSLT UUID::Tiny
cd /docker-build/support
git clone https://github.com/brucemiller/LaTeXML.git
cd LaTeXML
git checkout v0.8.0
perl Makefile.PL
make
make test
make install

# Cleanup
rm -rf $HOME/.cpan/build/* $HOME/.cpan/sources/authors/id $HOME/.cpan/cpan_sqlite_log.* /tmp/cpan_install_*.txt
apt-get -y remove --auto-remove autoconf automake dpkg-dev g++ gcc libc6-dev make software-properties-common
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
