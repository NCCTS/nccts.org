# DOCKER-VERSION 0.12.0

# Use ncct/baseimage as base image.
FROM nccts/baseimage:0.0.1

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# nvm / Node
USER sailor
WORKDIR /home/sailor
ENV HOME /home/sailor
RUN git clone https://github.com/creationix/nvm.git ~/.nvm
RUN printf "\nsource ~/.nvm/nvm.sh\n" >> .bashrc
RUN bash -c "source ~/.nvm/nvm.sh && nvm install v0.10.28"
USER root
WORKDIR /
ENV HOME /root

# # Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
