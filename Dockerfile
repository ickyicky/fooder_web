# BUILD
FROM node:16.14-alpine

COPY ./build/web /app

WORKDIR /app/

RUN apk --no-cache add curl
RUN npm install --global http-server

EXPOSE 80

CMD ["npx", "http-server", "-p", "80"]
