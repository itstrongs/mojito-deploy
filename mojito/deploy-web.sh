#!/bin/sh

app_dir='/opt/mojito-parent'
app_name='mojito-doc-note-web'

git pull
cd ../${app_name}
npm run build

if docker ps -a | grep -q ${app_name}; then
  docker stop ${app_name}
  docker rm ${app_name}
  docker rmi ${app_name}
fi

docker build -t ${app_name} .
docker run --name ${app_name} -d -p 80:80 -p 433:433 --net=host \
 -v ${app_dir}/${app_name}/resources/nginx.conf:/etc/nginx/nginx.conf ${app_name}

echo "------------ 部署完成 ------------"