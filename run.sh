#!/bin/ash

docker build -t dddmaster/nat_router:latest .

#docker stop routetest
#docker rm routetest

docker run --rm --network=host --privileged --name routetest -it dddmaster/nat_router:latest
#docker run --rm --name routetest -it dddmaster/nat_router:latest
