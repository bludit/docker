# Bludit Docker Image
This Docker container provides a quick solution to run a website with Bludit, if you are going to run this Docker container in a production environment, I would recommend to improve the security on it.

[![Docker Hub](https://img.shields.io/badge/Docker-Hub-blue.svg)](https://hub.docker.com/r/bludit/docker/)

[![Kubernetes](https://img.shields.io/badge/Kubernetes-Deployment-blue.svg)](https://github.com/bludit/docker/tree/master/kubernetes)

### Run the container

```
$ docker run --name bludit -p 8000:80 -d bludit/docker:latest
```

To get access visit with your browser http://localhost:8000

### Run the container and mounting a volume to persist data

```
mkdir ~/bludit

docker run --name bludit \
    -p 8000:80 \
    -v ~/bludit:/usr/share/nginx/html/bl-content \
    -d bludit/docker:latest
```

To get access visit with your browser http://localhost:8000

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

Run Bludit on K8s.

```
$ kubectl apply -f kubernetes/deployment.yml
$ kubectl apply -f kubernetes/service.yml
```
