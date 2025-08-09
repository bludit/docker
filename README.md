# Bludit Docker Image

This Docker container provides a quick solution to run a website with Bludit. If you plan to run this Docker container in a production environment, it is recommended to enhance its security and scalability.

[![Docker Hub](https://img.shields.io/badge/Docker-Hub-blue.svg)](https://hub.docker.com/r/bludit/docker/)

[![Kubernetes](https://img.shields.io/badge/Kubernetes-Deployment-blue.svg)](https://github.com/bludit/docker/tree/master/kubernetes)

### Run the container

```
$ docker run --name bludit -p 8000:80 -d bludit/docker:latest
```

To get access, visit with your browser: [http://localhost:8000](http://localhost:8000)

### Run the container with persistent data

```
mkdir ~/bludit

docker run --name bludit \
    -p 8000:80 \
    -v ~/bludit:/usr/share/nginx/html/bl-content \
    -d bludit/docker:latest
```

#### Run the container with persistent themes & plugins

```
mkdir ~/bludit
mkdir ~/bludit-themes
mkdir ~/bludit-plugins

docker run --name bludit \
    -p 127.0.0.1:8000:80 \
    -v ~/bludit:/usr/share/nginx/html/bl-content \
    -v ~/bludit-themes:/usr/share/nginx/html/bl-themes \
    -v ~/bludit-plugins:/usr/share/nginx/html/bl-plugins \
    -d bludit/docker:latest
```

To get access, visit with your browser: [http://localhost:8000](http://localhost:8000)

### Stop the container

```
$ docker stop bludit
```

### Delete the container

```
$ docker rm bludit
```

### Delete the image

```
$ docker rmi bludit/docker:latest
```

## Kubernetes

The Kubernetes manifests are basic and can be improved for better security and shared storage to support multiple replicas.

```
$ kubectl apply -f kubernetes/deployment.yml
$ kubectl apply -f kubernetes/service.yml
```
