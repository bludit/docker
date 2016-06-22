# docker-nginx-php-fpm
Docker: Nginx + PHP-FPM

## Build
```
$ docker build -t nginx-php .
```

## Create container
```
$ docker run --name webserver01 -p 8000:80 -d nginx-php
```

## Logs
```
$ docker logs -f webserver01
```

## Add volumen
```
$ docker run --name webserver01 -p 8000:80 -d -v /data/www:/usr/share/nginx/html nginx-php
```

## Custom Nginx configurations
Custom virtual server
```
$ docker run --name webserver01 -p 8000:80 -d -v /data/default.conf:/etc/nginx/conf.d/default.conf:ro nginx-php
```

Custom Nginx configuration, remember add the propertie `daemonize = no;`
```
$ docker run --name webserver01 -p 8000:80 -d -v /data/nginx.conf:/etc/nginx/nginx.conf:ro nginx-php
```
