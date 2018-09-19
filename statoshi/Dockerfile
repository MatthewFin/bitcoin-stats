FROM debian:latest
MAINTAINER Invictus Capital <matthew@invictuscapital.com>
LABEL statoshi.image-specs="{\"Description\":\"A containerized Statoshi\, a fork of Bitcoin Core\, running on Debian using Docker\"}"

# 0. update Debain and installing dependencies

RUN apt-get update
RUN apt-get install -y nano wget
RUN apt-get install -y autoconf automake autotools-dev build-essential python3 bsdmainutils git libboost-all-dev libssl-dev libtool pkg-config libevent-dev
RUN useradd -d /home/statoshi -m -s /bin/bash -c "Statoshi" statoshi
RUN apt-get install -y sudo
RUN echo "statoshi ALL=(ALL) ALL" >> /etc/sudoers
RUN mkdir /home/statoshi/.bitcoin && mkdir /home/statoshi/.scripts && mkdir /home/statoshi/log

ADD conf/bitcoind.check.sh /home/statoshi/.scripts/bitcoind.check.sh
RUN chmod +x /home/statoshi/.scripts/*.sh
ADD conf/bitcoin.conf /home/statoshi/.bitcoin/bitcoin.conf

RUN chown statoshi:statoshi -R /home/statoshi

# RUN cd /home/statoshi && git clone http://github.com/jlopp/bitcoin-utils
# RUN sed -i 's/memory          = psutil.phymem_usage()/memory          = psutil.virtual_memory()/g' /home/statoshi/bitcoin-utils/systemMetricsDaemon.py

RUN cd /tmp && git clone  https://github.com/jlopp/statoshi.git
RUN cd /tmp/statoshi && ./autogen.sh
RUN cd /tmp/statoshi && ./configure --disable-wallet --with-cli --without-gui --enable-hardening --without-miniupnpc
RUN cd /tmp/statoshi && make
RUN cd /tmp/statoshi && make install

ADD conf/bitcoind.conf /etc/default/bitcoind
ADD conf/bitcoind.init /etc/init.d/bitcoind
RUN chmod +x /etc/init.d/bitcoind

RUN apt-get install -y rcconf sysv-rc-conf cron
RUN update-rc.d bitcoind defaults
RUN update-rc.d cron defaults
RUN rm /etc/crontab
ADD conf/crontab /etc/crontab

EXPOSE 8333 8125 8125/udp
