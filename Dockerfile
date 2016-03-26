FROM node:slim

MAINTAINER jakkn <jakobknutsen@gmail.com>

# Build and install. Avoid splitting this to minimize layer size
RUN buildDeps='gcc g++ git cmake python pkg-config' \
    && libDeps='pkg-config libbz2-dev zlib1g-dev libssl-dev libstdc++6 libminiupnpc-dev libnatpmp-dev libtbb-dev libgeoip-dev libboost1.5*-dev libboost-regex1.5* libboost-thread1.5* libboost-system1.5* libleveldb-dev' \
    && websocket='libwebsocketpp-dev' \
    && repository='airdcpp-webclient' \
    && apt-get update \
    && apt-get install -y $buildDeps $libDeps $websocket \
    && git clone https://github.com/airdcpp-web/$repository.git \
    && cd $repository \
    && cmake . \
    && make -j2 \
    && make install \
    && rm -rf $repository \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean

CMD ["airdcppd"]