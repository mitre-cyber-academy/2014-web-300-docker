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
# ...put your own build instructions here...
RUN apt-get update
# Update these packages
RUN apt-get -y install git openssl ruby-dev
RUN git clone https://github.com/mitre-cyber-academy/2014-web-300.git /home/app/web-300
RUN chown -R app:app /home/app/web-300
# Hack to correct for old box
RUN echo :ssl_verify_mode: 0 >> ~/.gemrc
WORKDIR /home/app/web-300
ENV JRUBY_OPTS="--1.9 -Xcext.enabled=true"

RUN bundle install
RUN sudo -u app RAILS_ENV=production bundle exec rake assets:precompile
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD web-300.conf /etc/nginx/sites-enabled/web-300.conf

# If any environment variables need to be included 
# /etc/nginx/main.d/postgres-env.conf:
# env POSTGRES_PORT_5432_TCP_ADDR;
# env POSTGRES_PORT_5432_TCP_PORT;

# Dockerfile:
# ADD postgres-env.conf /etc/nginx/main.d/postgres-env.conf
# If nginx needs to be configured
# /etc/nginx/main.d/secret_key.conf:
# env SECRET_KEY=123456;

# /etc/nginx/conf.d/gzip_max.conf:
# gzip_comp_level 9;

# Dockerfile:
# ADD secret_key.conf /etc/nginx/main.d/secret_key.conf
# ADD gzip_max.conf /etc/nginx/conf.d/gzip_max.conf

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*