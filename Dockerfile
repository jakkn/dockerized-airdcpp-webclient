FROM node:slim
MAINTAINER jakkn <jakobknutsen@gmail.com>

# Build and install. Avoid splitting this to minimize layer size
RUN buildDeps=' \
        cmake \
        g++ \
        gcc \
        git \
        pkg-config \
        python \
    ' && \
    libDeps=' \
        pkg-config \
        libbz2-dev \
        zlib1g-dev \
        libssl-dev \
        libstdc++6 \
        libminiupnpc-dev \
        libnatpmp-dev \
        libtbb-dev \
        libgeoip-dev \
        libboost1.5*-dev \
        libboost-regex1.5* \
        libboost-thread1.5* \
        libboost-system1.5* \
        libleveldb-dev \
    ' && \
    websocket='libwebsocketpp-dev' && \
    repository='airdcpp-webclient' \
# Install build and runtime dependencies
    && apt-get update && apt-get install -y $buildDeps $libDeps $websocket \
# Build and install airdcpp-webclient
    && git clone https://github.com/airdcpp-web/$repository.git \
    && pushd $repository \
    && cmake . \
    && make -j2 \
    && make install \
    && popd \
    && rm -rf $repository \
# Remove build dependencies and all apt traces
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean

CMD ["airdcppd"]
