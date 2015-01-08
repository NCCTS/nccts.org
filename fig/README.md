# Usage Guides

The following are not shell scripts *per se*,  but rather guides for working in deployment and dev contexts. The top-level shell is assumed to be `bash`. The various commands can be pasted into a shell, but pasting large groups of them at a time is not guaranteed to work.

## Deploying remotely with Docker `machine`

```shell
machine create -d digitalocean \
               --digitalocean-access-token SOMEAPITOKEN \
               --digitalocean-image docker \
               --digitalocean-region nyc3 \
               --digitalocean-size 4gb \
               nccts-prod

export DOCKER_HOST=$(machine url) DOCKER_AUTH=identity

alias docker="$HOME/bin/docker-1.4.1-136b351e-identity"

docker run --name inception \
           --privileged \
           -d \
           --env DIND \
           -p 80:80 \
           quay.io/nccts/builder \
           'while true; do sleep 86400; done'

docker exec -it inception sudo -i -u sailor
export TERM=xterm-256color

docker pull quay.io/nccts/baseimage
docker pull quay.io/nccts/builder
docker pull quay.io/nccts/clojure
docker pull quay.io/nccts/latex
docker pull quay.io/nccts/nccts-data
docker pull quay.io/nccts/node

mkdir repos
cd repos
git clone https://github.com/NCCTS/nccts.org.git

# cd nccts.org/fig/prod/master
# -or-
cd nccts.org/fig/prod/tagged

fig up data
# for rekicks of master,tagged there's also
# fig up update
fig up builder
fig up -d http

command exit

open http://$(machine ip nccts-prod)/
```


## Deploying locally with `boot2docker`

```shell
# in the root of the nccts.org repository

scripts/clean.sh

docker run --name inception \
           -it --rm \
           -v /Users/michael/repos/NCCTS/nccts.org:/home/sailor/nccts.org \
           -v /var/run:/var/docker_host/run \
           quay.io/nccts/builder

export TERM=xterm-256color

# cd nccts.org/fig/prod/master
# -or-
# cd nccts.org/fig/prod/tagged
# -or-
cd nccts.org/fig/prod/mounted

fig up data
# for rekicks of master,tagged there's also
# fig up update
fig up builder
fig up http

# in another terminal
open http://$(boot2docker ip)/

# When finished with deployment review, don't forget to ctrl-c
# then `fig stop && fig rm --force -v`.
```


## Developing with `boot2docker`

```shell
# in the root of the nccts.org repository

scripts/clean.sh

docker run --name inception \
           -it --rm \
           -v /Users/michael/repos/NCCTS/nccts.org:/home/sailor/nccts.org \
           -v /var/run:/var/docker_host/run \
           quay.io/nccts/builder

export TERM=xterm-256color

tmux new-session -s fig/dev -d ' \
    tmux set-option -g status-bg colour202 ; \
    t_win_dev () { \
        tmux new-window -n "$1" \
                        -c /home/sailor/nccts.org/fig/dev \
                        -d "sleep $2 ; fig up $1 ; bash" ; \
    } ; \
    t_win_dev data    0 ; \
    t_win_dev builder 3 ; \
    t_win_dev http    3'

sleep 6

tmux new-session -s fig/build/dev -d ' \
    t_win_bld_dev () { \
        local curr_bldr="$(cd /home/sailor/nccts.org/fig/dev ; \
                        echo $(fig ps | awk "\$1 ~ /build/ { print \$1 }"))" ; \
        local s_bsh_cmd="(export TERM=xterm-256color ; \
                        cd /home/sailor/nccts.org/fig/build/dev ; \
                        sleep $2 ; \
                        fig up $1 ; \
                        bash)" ; \
        local d_exe_cmd=(sudo -i -u sailor -- bash -i -c "$s_bsh_cmd") ; \
        local t_win_c_a=(docker exec -it $curr_bldr \
                                bash -c "$(printf "%q " "${d_exe_cmd[@]}")") ; \
        local t_win_c_s="$(printf "%q " "${t_win_c_a[@]}")" ; \
        tmux new-window -n "$1" \
                        -c /home/sailor/nccts.org/fig/dev \
                        -d "$t_win_c_s" ; \
    } ; \
    t_win_bld_dev builddata 0 ; \
    t_win_bld_dev static    3 ; \
    t_win_bld_dev latex     3 ; \
    t_win_bld_dev generator 3'

sleep 6

tmux attach -t fig/build/dev:generator

# in another terminal
open http://$(boot2docker ip)/

# in yet another terminal, open to the root of the nccts.org repository
tail -f site/watchman-logs/*.log

# a clojure REPL should open at $(boot2docker ip):7888 but the latex builds
# should be completed prior to invoking `(org.nccts.nccts-site/export)` therein

# When finished with dev work, don't forget to `fig stop && fig rm --force -v` in
# both inception and builder contexts.
```
