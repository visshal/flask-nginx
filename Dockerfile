
# Install base os
FROM ubuntu:14.04

# 
MAINTAINER Vishal Mehta <visshal.mehta@gmail.com> 

# Setup repository mirror t aliyun.com & Start installing packages
#RUN perl -p -i.orig -e 's/archive.ubuntu.com/mirrors.aliyun.com\/ubuntu/' /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe multiverse >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y build-essential git
RUN apt-get install -y python python-dev python-setuptools python-pip python-distribute
RUN apt-get install -y nginx supervisor

# Installing uwsgi
RUN pip install uwsgi

# Install nginx
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get update
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get install -y sqlite3

# Copy our contents (scripts/packages/configs)
ADD . /home/docker/code/
# Copy static files to root (it is set in nginx-app.conf)
COPY static-html /usr/share/nginx/html

# Install External Packages (Not supported by pip) Rally Code
#RUN cd /home/docker/code/packages/RallyRestToolkitForPython && python setup.py install

# Setup all the configuration files
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /home/docker/code/nginx-app.conf /etc/nginx/sites-enabled/
RUN ln -s /home/docker/code/supervisor-app.conf /etc/supervisor/conf.d/
RUN mkdir -p /var/log/uwsgi

# Run pip to install requirement files
RUN pip install -r /home/docker/code/app/requirements.txt

# Define mountable directories.
#VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/usr/share/nginx/html"]

# Define working directory.
WORKDIR /etc/nginx


EXPOSE 80
EXPOSE 443
cmd ["supervisord", "-n"]