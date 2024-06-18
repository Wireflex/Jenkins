FROM ubuntu:24.10                     
RUN apt-get update                   
RUN apt-get install nginx -y         
COPY htmls/index.html /var/www/html/  
EXPOSE 80                             
CMD ["nginx","-g","daemon off;"]
