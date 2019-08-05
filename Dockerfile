FROM alpine:3.2

RUN apk --update add openjdk7-jre

CMD ["/usr/bin/java", "-version"]

docker pull durdn/minimal-java
docker run -t durdn/minimal-java

# Set environment

ENV JAVA_HOME /opt/jdk

ENV PATH ${PATH}:${JAVA_HOME}/bin