FROM nginx:alpine
RUN sudo apk update && apk add nginx
COPY ./index.html /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
