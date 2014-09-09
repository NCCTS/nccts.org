# DOCKER-VERSION 1.2.0, build fa7b24f

# Use ncct/baseimage as base image.
FROM nccts/baseimage:0.0.7

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
RUN bash -c "source ~/.nvm/nvm.sh && nvm install v0.10.29 && nvm alias default 0.10.29"
USER root
WORKDIR /
ENV HOME /root
# Use phusion/baseimage's init system as the entrypoint:
# 'entry.sh' starts tmux as the 'sailor' user with a session named 'clojure'
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/bin/entry.sh", "node"]
CMD [""]

# # Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# example usage
# --------------------------------------------------
# docker run -it --rm nccts/node
# docker run -it --rm nccts/node 'source ./.nvm/nvm.sh && node'
