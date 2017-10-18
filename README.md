# Bludit Docker Image

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
