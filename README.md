# Bludit Docker Image
You can run Bludit as a Docker container.

[![Docker Hub](https://img.shields.io/badge/Docker-Hub-blue.svg)](https://hub.docker.com/r/bludit/docker/)

[![Kubernetes](https://img.shields.io/badge/Kubernetes-Deployment-blue.svg)](https://github.com/bludit/docker/tree/master/kubernetes)

Find the deployment and service for Kubernetes on the directory `kubernetes`.

### Run the container

```
$ docker run --name bludit -p 8000:80 -d bludit/docker:latest
```

To get access go with your browser to http://localhost:8000

## Run the container and mounting a volume to persist data

```
mkdir ~/bludit

docker run --name bludit \
    -p 8000:80 \
    -v ~/bludit:/usr/share/nginx/html/bl-content \
    -d bludit/docker:latest
```

To get access go with your browser to http://localhost:8000

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

### Kubernetes

Run Bludit on K8s.

```
$ kubectl apply -f kubernetes/deployment.yml
$ kubectl apply -f kubernetes/service.yml
```
