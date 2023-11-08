#!/bin/sh

image_name='export_jmx_kafka'

if docker ps -a | grep -q ${image_name}; then
  docker stop ${image_name}
  docker rm ${image_name}
  docker rmi ${image_name}
fi

docker build -t ${image_name} .
docker run -v --net=host --name ${image_name} -d -p 12345:12345 ${image_name}