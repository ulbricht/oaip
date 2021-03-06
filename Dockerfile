FROM phusion/baseimage:0.9.22
MAINTAINER Kristian Garza "kgarza@datacite.org"

# Set correct environment variables
ENV HOME /home/app
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV CATALINA_HOME /usr/share/tomcat7
ENV CATALINA_BASE /var/lib/tomcat7
ENV CATALINA_PID /var/run/tomcat7.pid
ENV CATALINA_SH /usr/share/tomcat7/bin/catalina.sh
ENV CATALINA_TMPDIR /tmp/tomcat7-tomcat7-tmp
ENV DOCKERIZE_VERSION v0.6.0
ENV SHELL /bin/bash

# Use baseimage-docker's init process
CMD ["/sbin/my_init"]

# Install Java and Tomcat
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && apt-get install -y wget apt-utils build-essential zlib1g-dev git nodejs ruby ruby-dev pandoc && \
    apt-get install -yqq software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -yqq oracle-java8-installer && \
    apt-get install -yqq oracle-java8-set-default && \
    apt-get -yqq install tomcat7 maven && \
    apt-get install -y nginx nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /var/cache/oracle-jdk8-installer

# Configure Tomcat
RUN ln -s /var/lib/tomcat7/common $CATALINA_HOME/common && \
    ln -s /var/lib/tomcat7/server $CATALINA_HOME/server && \
    ln -s /var/lib/tomcat7/shared $CATALINA_HOME/shared && \
    ln -s /etc/tomcat7 $CATALINA_HOME/conf && \
    mkdir $CATALINA_HOME/temp && \
    mkdir -p $CATALINA_TMPDIR

RUN rm -rf /var/lib/tomcat7/webapps/docs* && \
    rm -rf /var/lib/tomcat7/webapps/examples* && \
    rm -rf /var/lib/tomcat7/webapps/ROOT*

# install dockerize
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Remove unused SSH service
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Enable Passenger and Nginx and remove the default site
# Preserve env variables for nginx
RUN rm -f /etc/service/nginx/down && \
    rm /etc/nginx/sites-enabled/default && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
	  ln -sf /dev/stderr /var/log/nginx/error.log
COPY vendor/docker/nginx.conf /etc/nginx/nginx.conf
COPY vendor/docker/webapp.conf /etc/nginx/sites-enabled/webapp.conf
COPY vendor/docker/cors /etc/nginx/conf.d/cors

# Use Amazon NTP servers
COPY vendor/docker/ntp.conf /etc/ntp.conf

# Copy webapp folder
COPY . /home/app/
WORKDIR /home/app

# Add Runit script for tomcat
RUN mkdir /etc/service/tomcat && \
    chown tomcat7. /etc/service/tomcat -R
COPY vendor/docker/tomcat.sh /etc/service/tomcat/run

# Copy server configuration (for context path)
COPY vendor/docker/server.xml /etc/tomcat7/server.xml

# Build static site
# Install Ruby gems for middleman
WORKDIR /home/app/vendor/middleman
RUN gem install bundler && \
    bundle install
WORKDIR /home/app

# Run additional scripts during container startup (i.e. not at build time)
# Process templates using ENV variables
# Compile project
RUN mkdir -p /etc/my_init.d
COPY vendor/docker/70_templates.sh /etc/my_init.d/70_templates.sh
COPY vendor/docker/80_install.sh /etc/my_init.d/80_install.sh
COPY vendor/docker/90_index_page.sh /etc/my_init.d/90_index_page.sh

EXPOSE 80
