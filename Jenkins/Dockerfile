FROM ubuntu:24.10
RUN sed -i 's/archive.ubuntu.com/us.archive.ubuntu.com/' /etc/apt/sources.list
RUN apt-get update && apt-get install nginx -y
COPY ./index.html /var/www/html/
EXPOSE 80
