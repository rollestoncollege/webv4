FROM node:lts AS build
WORKDIR /app
COPY . .
RUN apt update
RUN apt-get install libvips -y
RUN apt-get install libc6 -y
RUN npm install --platform=linux --arch=x64 sharp --force
RUN npm i --force
RUN npm run build

FROM httpd:2.4 AS runtime
COPY --from=build /app/dist /usr/local/apache2/htdocs/
EXPOSE 80