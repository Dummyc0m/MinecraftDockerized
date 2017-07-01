FROM openjdk:8u131-jdk-alpine

RUN apk add --no-cache wget \
          su-exec \
          bash

RUN addgroup -g 1000 minecraft \
  && adduser -Ss /bin/false -u 1000 -G minecraft -h /data minecraft \
  && chown minecraft:minecraft /data

COPY start.sh /start
EXPOSE 25565
ENTRYPOINT [ "/start" ]

WORKDIR /data
VOLUME /data

ENV UID=1000 GID=1000 \
    JAVA_OPTS="" \
    VERSION="1.12"
