# DOCKER-VERSION 0.12.0

# Use ncct/baseimage as base image.
FROM nccts/baseimage:0.0.7

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Java
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer
RUN ldconfig

#  Leiningen / Clojure
USER sailor
WORKDIR /home/sailor
ENV HOME /home/sailor
RUN mkdir bin && wget -O bin/lein https://raw.githubusercontent.com/technomancy/leiningen/2.4.2/bin/lein
RUN chmod +x bin/lein && printf "\nexport PATH=~/bin:\$PATH\n" >> .bashrc
RUN bin/lein self-install && bin/lein version
USER root
WORKDIR /
ENV HOME /root

# # Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
