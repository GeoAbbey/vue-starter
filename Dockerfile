FROM node:16-alpine as build
COPY . /app/
WORKDIR /app
RUN npm install
RUN npm run build

FROM nginx:1.20.2-alpine
RUN sed -ie '/index.htm;/a try_files $uri $uri.html $uri/ $uri/index.html?$args /index.html?$args;' /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist/ /usr/share/nginx/html/