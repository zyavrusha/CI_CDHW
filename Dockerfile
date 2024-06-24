# use build as source for the first stage
FROM alpine as base1

# install nginx

RUN apk update && apk add nginx 

# copy local configuration and custom index  files 
COPY default.conf /etc/nginx/http.d/default.conf
COPY index.html /var/www/html/index.html

# expose port 80
EXPOSE 80

# start nginx with custom page 
CMD [ "nginx", "-g", "daemon off;"]
