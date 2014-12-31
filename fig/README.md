## Deploying with Docker `machine`

```shell
$ machine create -d digitalocean \
               --digitalocean-access-token SOMEAPITOKEN \
               --digitalocean-image docker \
               --digitalocean-region nyc3 \
               --digitalocean-size 4gb \
               some-machine-name

$ export DOCKER_HOST=$(machine url) DOCKER_AUTH=identity

$ alias docker="$HOME/bin/docker-1.3.1-dev-identity-auth"

$ docker run --name inception \
             -d --privileged \
             --env DIND \
             -p 80:80 \
             quay.io/nccts/builder \
             'while true; do sleep 86400; done'

$ docker exec -it inception bash

$ su - sailor

$ mkdir repos
$ cd repos
$ git clone https://github.com/NCCTS/nccts.org.git

$ docker pull quay.io/nccts/baseimage
$ docker pull quay.io/nccts/builder
$ docker pull quay.io/nccts/clojure
$ docker pull quay.io/nccts/latex
$ docker pull quay.io/nccts/nccts-data
$ docker pull quay.io/nccts/node

$ cd nccts.org/fig/prod/tagged
$ fig up data
$ fig up builder
$ fig up -d http

$ command exit
$ exit

$ open http://$(machine ip some-machine-name)/

```
