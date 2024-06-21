# FROM jamiehewland/alpine-pypy:2.7-7.3.0-alpine3.11
FROM alpine:3.20.1
LABEL maintainer "Jamie Hewland <jhewland@gmail.com>"

# Add build dependencies
RUN apk add --no-cache --virtual .build-deps \
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        patch \
        pypy \
        bzip2-dev \
        expat-dev \
        gcc \
        gdbm-dev \
        libc-dev \
        libffi-dev \
        linux-headers \
        make \
        ncurses-dev \
        openssl-dev \
        pax-utils \
        readline-dev \
        sqlite-dev \
        tar \
        tk \
        tk-dev \
        xz-dev \
        zlib-dev

# Download the source
ENV PYPY_VERSION 7.3.16
ENV PYPY_SHA256SUM 4a3a3177d0a1f51d59982bb981d1d485403bda3419d5437b9e077f55f59424ff

RUN set -ex; \
    wget -O pypy.tar.bz2 "https://downloads.python.org/pypy/pypy3.10-v${PYPY_VERSION}-src.tar.bz2"; \
    echo "$PYPY_SHA256SUM *pypy.tar.bz2" | sha256sum -c -; \
    mkdir -p /usr/src/pypy; \
    tar -xjC /usr/src/pypy --strip-components=1 -f pypy.tar.bz2; \
    rm pypy.tar.bz2

WORKDIR /usr/src/pypy

COPY patches /patches
RUN set -ex; \
    for patch in /patches/*.patch; do \
        patch -p1 -E -i "$patch"; \
    done

COPY build.sh /build.sh
CMD ["/build.sh"]

VOLUME /tmp
