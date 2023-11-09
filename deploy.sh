#!/bin/bash

deploy_param="$1"

if [ "$deploy_param" = "jmx" ]; then
  cd prometheus
  sh deploy.sh $2
elif [ "$deploy_param" = "mount_disk" ]; then
  sh linux/mount_disk.sh /home
elif [ "$deploy_param" = "mojito-server" ]; then
  sh mojito/install-server.sh
elif [ "$deploy_param" = "mojito-web" ]; then
  sh mojito/install-web.sh
elif [ "$deploy_param" = "mojito-all" ]; then
  sh mojito/install-server.sh
  sh mojito/install-web.sh
else
  echo "请提供部署参数"
  exit 1
fi