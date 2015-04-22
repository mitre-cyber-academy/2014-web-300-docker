# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-ruby21:0.9.15
MAINTAINER Kyle Fagan kfagan@mitre.org
# Set correct environment variables.
ENV HOME /root
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
# Update these packages
RUN apt-get -y install git openssl ruby-dev
RUN git clone https://github.com/mitre-cyber-academy/2014-web-300.git /home/app/web-300
# Hack to correct for old box
RUN echo :ssl_verify_mode: 0 >> ~/.gemrc
ENV JRUBY_OPTS="--1.9 -Xcext.enabled=true"
WORKDIR /home/app/web-300
RUN bundle install
# Update database settings to work with separate DB container
RUN rm /home/app/web-300/config/database.yml
ADD database.yml /home/app/web-300/config/database.yml
RUN chown -R app:app /home/app/web-300
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD web-300.conf /etc/nginx/sites-enabled/web-300.conf
ADD postgres-env.conf /etc/nginx/main.d/postgres-env.conf
ADD rails-env.conf /etc/nginx/main.d/postgres-env.conf
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*