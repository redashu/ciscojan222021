FROM centos
MAINTAINER  ashutoshh@linux.com
RUN yum install httpd -y
COPY  .  /var/www/html/
EXPOSE 80
# to set default application port number when we create container 
ENTRYPOINT  httpd -DFOREGROUND
# ENTRYPOINT is the replacement of CMD 
# As assignment you can tell me tomorrow diff b/w CMD & ENTRYPOINT
# systemctl start httpd -- "httpd -DFOREGROUND"
