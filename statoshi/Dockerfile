FROM debian:latest
MAINTAINER Invictus Capital <matthew@invictuscapital.com>

RUN apt-get update
RUN apt-get install -y nano wget procps
RUN apt-get install -y autoconf automake autotools-dev build-essential python3 bsdmainutils git libboost-all-dev libssl-dev libtool pkg-config libevent-dev
RUN apt-get install -y sudo
RUN mkdir /root/.bitcoin

ADD conf/bitcoin.conf /root/.bitcoin/bitcoin.conf

RUN cd /tmp && git clone https://github.com/jlopp/statoshi.git
RUN cd /tmp/statoshi && ./autogen.sh
RUN cd /tmp/statoshi && ./configure --disable-wallet --with-cli --without-gui --enable-hardening --without-miniupnpc
RUN cd /tmp/statoshi && make
RUN cd /tmp/statoshi && make install

ADD conf/bitcoind.conf /etc/default/bitcoind

EXPOSE 8333 8125 8125/udp
VOLUME ["/root/.bitcoin"]
CMD ["bitcoind"]
