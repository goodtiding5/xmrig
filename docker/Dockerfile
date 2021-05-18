FROM alpine:latest AS build

COPY . /build

RUN set -xe \
&&  echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
&&  apk --update add util-linux build-base cmake libuv-static libuv-dev openssl-dev hwloc-dev@community \
&&  mkdir -p /build/release \
&&  cd /build/release \
&&  cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib/libuv.a \
&&  make -j $(nproc)

FROM alpine:latest

LABEL maintainer="Kenneth Zhao (ken@epenguin.com)"

COPY --from=build /build/release/xmrig /usr/local/bin
COPY docker/entrypoint.sh /entrypoint.sh
COPY docker/config.sample.json /usr/local/etc/config.sample.json

RUN set -xe \
&&  echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
&&  apk --no-cache --update add tini libssl1.1 hwloc@community \
&&  chmod 0555 /entrypoint.sh
    
EXPOSE 3000

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]
