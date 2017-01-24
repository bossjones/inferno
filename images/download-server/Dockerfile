From nginx:latest
RUN apt-get update
RUN apt-get install -y wget
RUN mkdir -p /usr/share/nginx/html/spark && cd /usr/share/nginx/html/spark && wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz 
COPY index.html /usr/share/nginx/html/
