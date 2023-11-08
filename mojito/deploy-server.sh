#!/bin/sh

app_dir='/opt/mojito-parent'
app_name="mojito-doc-note-server"

# 首次构建
if [[ $1 == "--init" ]]; then
  git clone git@github.com:itstrongs/mojito-note-back.git
fi

git pull
cd ../${app_name}
mvn clean install -DskipTests=true

if docker ps -a | grep -q ${app_name}; then
  docker stop ${app_name}
  docker rm ${app_name}
  docker rmi ${app_name}
fi

docker build -t ${app_name} .
docker run -v ${app_dir}/logs:${app_dir}/logs \
 --net=host --name ${app_name} -d -p 18080:18080 ${app_name}

echo "------------ 部署完成 ------------"