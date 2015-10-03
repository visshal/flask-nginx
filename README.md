## Fnginx DockerFile (Flask & Nginx)

In order to meet need of serving static html files and dynamic python web-services having flask and nginx on one machine is more efficient than rendering static html file in python embeded code in Flask or any framework.

### Build and run
* docker build -t name/tag .
* docker run -d -p 80:80 name/tag

### Write your web-servie
/app directory contains sample flask app routed to /service with just a welcome message return. You can fork this repo and more complex web-services that can return dynamic responses.

### Proxy Tips
* Behind proxy DNS server to 8.8.8.8 in default vm of docker where docker host runs
* And set http_proxy and https_proxy
* While behind proxy remove those (commented ‘em)

### How to delete all docker images at once.
*  docker images | grep -vi image | awk '{print $3; cmd="docker rmi -f " $3; system(cmd)'}

### How to delete all containers
* docker ps | grep -vi container | awk ‘{print $1; cmd=“docker kill “ $1; system(cmd)’}

### How to run docker behind proxy. (On Mac-Os X)
* docker-machine ssh default
* sudo vi /var/lib/boot2docker/profile
add following lines.
export HTTP_PROXY=http://your.proxy.name:8080
export HTTPS_PROXY=http://your.proxy.name:8080
* docker-machine restart default

### Note: Remember on mac osx docker-machine has different architecutre since small kernel based VM is the running in virtual box along with docker deamon. Hence docker-machine and docker commands on your os-x are clients where as 'default' light weight VM is the server. And that server has to set the proxy in /var/lib/boot2docker/profile

### Reference
[http://flask.pocoo.org/docs/deploying/uwsgi/#configuring-nginx](http://flask.pocoo.org/docs/deploying/uwsgi/#configuring-nginx)