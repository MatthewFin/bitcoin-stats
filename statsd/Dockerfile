FROM phusion/baseimage:0.10.2
MAINTAINER Invictus Capital <matthew@invictuscapital.com>
# based on https://github.com/graphite-project/docker-graphite-statsd/blob/master/Dockerfile

RUN apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install nano \
  python-dev \
  expect \
  git \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

ARG statsd_version=v0.8.0
ARG statsd_repo=https://github.com/etsy/statsd.git

# install statsd
RUN git clone -b ${statsd_version} ${statsd_repo} /opt/statsd
# config statsd
ADD conf/opt/statsd/config_*.js /opt/statsd/

# daemon
ADD conf/etc/service/statsd/run /etc/service/statsd/run

# default conf setup
ADD conf /etc/graphite-statsd/conf
ADD conf/etc/my_init.d/01_conf_init.sh /etc/my_init.d/01_conf_init.sh

# cleanup
RUN apt-get clean\
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# defaults
EXPOSE 8125/udp 8126 2003
VOLUME ["/opt/statsd", "/var/log"]
WORKDIR /
ENV HOME /root
ENV STATSD_INTERFACE udp

CMD ["/sbin/my_init"]
