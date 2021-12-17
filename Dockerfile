FROM alpine:latest

RUN apk add bash
RUN apk add iperf3
RUN apk add jq

RUN mkdir /logs

COPY entrypoint.sh /

ENV IPERF3_INTERVAL=10s

ENTRYPOINT /entrypoint.sh
