# Docker version 1.1.2, build d84a070
FROM nccts/baseimage:0.0.8

# nccts/latex
# Version: 0.0.8
MAINTAINER "Michael Bradley" <michael.bradley@nccts.org>
# Ave, Regina Caelorum, ave, Domina Angelorum: salve, radix, salve, porta!

# Cache buster
ENV REFRESHED_AT [2014-09-09 Tue 14:09]

# Set environment variables
ENV HOME /root

# Add supporting files for the build
# ----------------------------------
# SHOULD REVISE setup.sh and augment mirror.sh so that the local texlive-mirror
# can be accessed via a local static web server; then via .dockerignore the
# texlive-mirror can be excluded from the build context, which should help cut
# down on the final image size

# `python -m SimpleHTTPServer [port]` is probably a good thing to rely on in
# augmented mirror.sh, but should detect python3 and use `python -m http.server
# [port]` instead; that would leave choosing a port which might conflict with
# something already running, but can pick something like 12345 and in README.md
# give clear instructions on what to change in setup. sh,user_sailor.sh if a
# different port is used; will need to think about how the docker build can
# "talk to" the static web server running on the docker host and document that
# carefully as well; also need to figure out if that kind of local static HTTP
# server will work satisfactorily with the '-repository' flag for the texlive
# install script, i.e. maybe it needs to be FTP instead, or maybe the directory
# listing my the python server won't match up with what the install script
# expects of an HTTP repo-mirror of CTAN
ADD . /docker-build

# Run main setup script, cleanup supporting files
RUN chmod -R 777 /docker-build && /docker-build/setup.sh && rm -rf /docker-build

# Use phusion/baseimage's init system as the entrypoint:
# 'entry.sh' starts tmux as the 'sailor' user with a session named 'latex'
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/bin/entry.sh", "latex"]
CMD [""]

# example usage
# --------------------------------------------------
# docker run -it --rm nccts/latex
