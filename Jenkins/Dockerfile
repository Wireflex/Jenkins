FROM ubuntu:24.10
RUN sudo apt-get install nginx -y
COPY ./index.html /var/www/html/
EXPOSE 80
CMD ["nginx","-g","daemon off;"]
