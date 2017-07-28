#
# image for the https://github.com/trueanthem/prometheus-kafka-consumer-group-exporter
#
FROM alpine:3.5

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.5/community/" >> /etc/apk/repositories && \
    apk --update add ca-certificates graphicsmagick@community && \
    rm -rf /var/cache/apk/*

ADD bin/ /usr/local/exporter/

EXPOSE 7979

WORKDIR /usr/local/exporter

USER nobody

ENTRYPOINT ["./exporter"]
