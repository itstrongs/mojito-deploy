#!/bin/sh

jmx_type="$1"
image_name=''
jmx_port=''

placeholder="JMX_ENDPOINT"
config_file="config.yaml"

if [ "$jmx_type" = "kafka" ]; then
  image_name='export_jmx_kafka'
  jmx_port='19000'
#  actual_ip="10.70.80.9:12181"
  actual_ip="10.50.22.15:9999"
elif [ "$jmx_type" = "zookeeper" ]; then
  image_name='export_jmx_zookeeper'
  jmx_port='19001'
  actual_ip="10.70.80.9:12182"
else
  echo "参数异常"
  exit 1
fi

if docker ps -a | grep -q ${image_name}; then
  docker stop ${image_name}
  docker rm ${image_name}
  docker rmi ${image_name}
fi

cp config-template.yaml config.yaml
sed -i "s/$placeholder/$actual_ip/g" "$config_file"

docker build -t ${image_name} .
docker run --name ${image_name} -d -p ${jmx_port}:19000 ${image_name}

#rm -rf config.yaml