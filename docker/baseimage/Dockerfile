# Docker version 1.1.2, build d84a070
FROM phusion/baseimage:0.9.13

# nccts/baseimage
# Version: 0.0.8
MAINTAINER "Michael Bradley" <michael.bradley@nccts.org>
# Ave, maris stella, Dei mater alma, atque semper virgo, felix cœli porta.

# Cache buster
ENV REFRESHED_AT [2014-09-08 Sun 19:08]

# Set environment variables
ENV HOME /root

# Disable sshd
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Add supporting files for the build
ADD . /docker-build
RUN chmod -R 777 /docker-build

# Run main setup script
RUN /docker-build/setup.sh

# Cleanup
RUN rm -rf /docker-build

# Use baseimage-docker's init system as the entrypoint; by default fire up tmux
# as the 'sailor' user; exiting that session will drop back to a root shell
ENTRYPOINT ["/sbin/my_init", "--"]
CMD ["bash", "-l", "-c", "su -c 'tmux new-session -s base' - sailor"]

# Would allow `command exit` in a 'sailor' tmux/shell to drop back to a root shell
# CMD ["bash", "-l", "-c", "su -c 'tmux new-session -s base' - sailor; exec bash -l"]
