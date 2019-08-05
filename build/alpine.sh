echo "http://dl-4.alpinelinux.org/alpine/v3.9/main" >> /etc/apk/repositories && \
echo "http://dl-4.alpinelinux.org/alpine/v3.9/community" >> /etc/apk/repositories

apk update && \
	apk add build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    curl -v -j -k -L -H http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jdk-8u51-linux- i586.rpm> jdk-8u51-linux-i586.rpm
    curl unzip libexif udev chromium chromium-chromedriver wait4ports xvfb xorg-server dbus ttf-freefont mesa-dri-swrast \
    && rm -rf /var/cache/apk/*