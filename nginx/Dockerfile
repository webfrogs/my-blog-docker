FROM nginx
EXPOSE 80

COPY blog /etc/nginx/conf.d/default.conf
VOLUME /var/www/blog
CMD ["nginx", "-g", "daemon off;"]
