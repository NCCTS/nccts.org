docker run -it --name nccts-site -v /home/core/vagrant/site:/home/sailor/site nccts/baseimage:0.0.8 /bin/true

docker attach $(docker run -dit --volumes-from nccts-site -p 80:8080 nccts/node:0.0.8)
  then...
     npm install -g http-server
     cd site/build
     http-server -c-1 -p 8080
     <ctrl-p><ctrl-q>

