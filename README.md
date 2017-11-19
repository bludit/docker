# Bludit Docker Image
You can run Bludit as a container; The image is auto-generated from this repository on [Docker Hub](https://hub.docker.com/r/bludit/docker/).

You can find the deployment and service for Kubernetes on the directory `kubernetes`.

## Run the container
```
$ docker run --name bludit -p 8000:80 -d bludit/docker:latest
```
To get access go with your browser to http://localhost:8000

## Stop the container
```
$ docker stop bludit
```

## Delete the container
```
$ docker rm bludit
```

## Delete the image
```
$ docker rmi bludit/docker:latest
```

## Kubernetes
Run Bludit on K8s.
```
$ kubectl apply -f kuberntest/deployment.yml
$ kubectl apply -f kuberntest/service.yml
```