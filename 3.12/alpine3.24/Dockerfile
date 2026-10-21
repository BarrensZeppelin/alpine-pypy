# FROM jamiehewland/alpine-pypy:2.7-7.3.0-alpine3.11
FROM alpine:3.24.2
LABEL maintainer="Jamie Hewland <jhewland@gmail.com>"

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
ENV PYPY_VERSION=8.0.1 \
    PYPY_SHA256SUM=9d5c82d39d590dc04677f4721738b21d670570cdc9824c003836bafd38556cda

RUN set -ex; \
    wget -O pypy.tar.gz "https://downloads.python.org/pypy/pypy3.12-v${PYPY_VERSION}-src.tar.gz"; \
    echo "$PYPY_SHA256SUM *pypy.tar.gz" | sha256sum -c -; \
    mkdir -p /usr/src/pypy; \
    tar -xzC /usr/src/pypy --strip-components=1 -f pypy.tar.gz; \
    rm pypy.tar.gz

WORKDIR /usr/src/pypy

COPY patches /patches
RUN set -ex; \
    for patch in /patches/*.patch; do \
        patch -p1 -E -i "$patch"; \
    done

COPY build.sh /build.sh
CMD ["/build.sh"]

VOLUME /tmp
