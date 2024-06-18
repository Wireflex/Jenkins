FROM nginx:alpine
RUN apk update
RUN apk add nginx
COPY ./index.html /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
