FROM nginx
MAINTAINER  ashutoshh@linux.com
COPY  myapp.html /usr/share/nginx/html/index.html
COPY k8s.png  /usr/share/nginx/html/k8s.png
# /usr/share/nginx/html is default location for NGINX 
EXPOSE 80
# You don't have to define CMD / ENtrypoint becuase it will be used by FROM image
