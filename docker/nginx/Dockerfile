FROM nginx:1.21.4

RUN mkdir -p /usr/share/nginx/public

COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
