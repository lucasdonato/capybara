echo "http://dl-4.alpinelinux.org/alpine/v3.9/main" >> /etc/apk/repositories && \
echo "http://dl-4.alpinelinux.org/alpine/v3.9/community" >> /etc/apk/repositories


apt-add-repository ppa:qameta/allure
apt-get update
apt-get install allure


apk update && \
	apk add build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    curl unzip libexif udev chromium chromium-chromedriver nodejs wait4ports xvfb xorg-server dbus ttf-freefont mesa-dri-swrast \
    && rm -rf /var/cache/apk/*


    