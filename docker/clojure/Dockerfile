# Docker version 1.1.2, build d84a070
FROM nccts/baseimage:0.0.8

# nccts/clojure
# Version: 0.0.8
MAINTAINER "Michael Bradley" <michael.bradley@nccts.org>
# Salve, Regina, Mater misericordiæ, vita, dulcedo, et spes nostra, salve.

# Cache buster
ENV REFRESHED_AT [2014-09-08 Mon 21:30]

# Set environment variables
ENV HOME /root

# Add supporting files for the build
ADD . /docker-build

# Run main setup script, cleanup supporting files
RUN chmod -R 777 /docker-build && /docker-build/setup.sh && rm -rf /docker-build

# Use phusion/baseimage's init system as the entrypoint:
# 'entry.sh' starts tmux as the 'sailor' user with a session named 'clojure'
ENTRYPOINT ["/sbin/my_init", "--", "/usr/local/bin/entry.sh", "clojure"]
CMD [""]

# example usage
# --------------------------------------------------
# docker run -it --rm nccts/clojure
# docker run -it --rm nccts/clojure lein repl
