# https://github.com/jpetazzo/dind
FROM ubuntu:14.04
MAINTAINER kfagan@mitre.org
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
RUN curl -sSL https://get.docker.com/ubuntu/ | sh
RUN curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN mkdir /home/docker/
RUN git clone https://github.com/mitre-cyber-academy/2014-web-300-docker.git /home/docker/
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker
ADD ./start-challenge /usr/local/bin/start-challenge
RUN chmod +x /usr/local/bin/start-challenge
VOLUME /var/lib/docker
CMD ["start-challenge"]
