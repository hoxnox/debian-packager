FROM debian:8
LABEL description="Building deb packages for Debian8 86_64"

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    cmake \
    make \
    libgtest-dev \
    automake \
    autoconf \
    libtool \
    wget \
    flex \
    bison \
    sqlite3

RUN TEMP_DEB="$(mktemp)" && wget -O "$TEMP_DEB" 'https://github.com/conan-io/conan/releases/download/1.21.0/conan-ubuntu-64_1_21_0.deb' && dpkg -i "$TEMP_DEB" && rm -f "$TEMP_DEB"
RUN TEMP="$(mktemp -d)" && cd "$TEMP" && wget -O cmake.tar.gz 'https://cmake.org/files/v3.10/cmake-3.10.1.tar.gz' && tar -zxvf cmake.tar.gz && cd cmake-3.10.1 && ./configure && make -j8 install && cd / && rm -rf "$TEMP"

RUN mkdir /src
RUN mkdir /build
RUN mkdir /result
WORKDIR /build

CMD ["/bin/bash"]
