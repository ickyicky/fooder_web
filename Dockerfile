# BUILD
FROM debian:stable-slim AS build-env

RUN apt-get update && apt-get install -yq curl file git unzip xz-utils zip && rm -rf /var/lib/apt/lists/*

RUN useradd -m flutter
RUN groupadd flutterusers
RUN usermod -aG flutterusers flutter
RUN mkdir /opt/flutter && chown -R flutter:flutter /opt/flutter
USER flutter
WORKDIR /home/flutter

RUN git clone https://github.com/flutter/flutter.git /opt/flutter
ENV PATH $PATH:/opt/flutter/bin
RUN flutter config --no-analytics --enable-web --no-enable-android --no-enable-ios
RUN flutter precache --web
RUN flutter create --platforms web dummy && rm -rf dummy

COPY . /home/flutter
USER root
RUN chown -R flutter:flutter /home/flutter
USER flutter
WORKDIR /home/flutter
RUN flutter build web

# DEPLOY
FROM node:16.14-alpine

COPY --from=build-env /home/flutter/build/web /app/

WORKDIR /app/

RUN apk --no-cache add curl
RUN npm install --global http-server

EXPOSE 80

CMD ["npx", "http-server", "-p", "80"]
