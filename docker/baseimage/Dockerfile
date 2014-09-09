# Docker version 1.1.2, build d84a070
FROM phusion/baseimage:0.9.13

# nccts/baseimage
# Version: 0.0.8
MAINTAINER "Michael Bradley" <michael.bradley@nccts.org>
# Ave, maris stella, Dei mater alma, atque semper virgo, felix cœli porta.

# Cache buster
ENV REFRESHED_AT [2014-09-08 Mon 19:08]

# Set environment variables
ENV HOME /root

# Disable sshd
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Add supporting files for the build
ADD . /docker-build

# Run main setup script, cleanup supporting files
RUN chmod -R 777 /docker-build && /docker-build/setup.sh && rm -rf /docker-build

# Use phusion/baseimage's init system as the entrypoint:
# 'entry.sh' starts tmux as the 'sailor' user with a session named 'base'
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/bin/entry.sh", "base"]
CMD [""]

# example usage
# --------------------------------------------------
# docker run -it --rm nccts/baseimage
# docker run -it --rm nccts/baseimage top
# docker run -it --rm nccts/baseimage 'top'
# docker run -it --rm nccts/baseimage "top"

# docker run -it --rm nccts/baseimage top -u sailor
# docker run -it --rm nccts/baseimage 'top -u sailor'
# docker run -it --rm nccts/baseimage "top -u sailor"

# docker run -it --rm nccts/baseimage   \
#     tmux new-window -n win0 -d top \; \
#     tmux new-window -n win1 -d top \; \
#     tmux new-window -n win2

# docker run -it --rm nccts/baseimage '            \
#     tmux new-window -n win0 -d "top -u root"   ; \
#     tmux new-window -n win1 -d "top -u sailor" ; \
#     tmux new-window -n win2'

# docker run -it --rm nccts/baseimage "            \
#     tmux new-window -n win0 -d 'top -u root'   ; \
#     tmux new-window -n win1 -d 'top -u sailor' ; \
#     tmux new-window -n win2"
