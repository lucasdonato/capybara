FROM openjdk:8-jre-alpine

RUN apk add --update \
    curl \
    && rm -rf /var/cache/apk/*