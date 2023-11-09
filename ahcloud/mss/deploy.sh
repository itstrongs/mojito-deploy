#!/bin/sh

directory="/data/data-platform"
if [ ! -d "$directory" ]; then
  cd /data
  openssl des3 -d -k 1qazcde3\!@# -salt -in data-platform-release-mss-custome-v1.0.0-o8-centos-dev.tar | tar zxvf -
fi

cd /data/data-platform

case "$1" in
    1)
        echo "Deploying Node 1"
        sh install.sh <<EOF
y
7
2
zookeeper1 kafka1 clickhouse1 elasticsearch1 elasticsearch4 minio1 minio2 kibana
1
EOF
        ;;
    2)
        echo "Deploying Node 2"
        sh install.sh <<EOF
y
7
2
zookeeper2 kafka2 clickhouse2 elasticsearch2 minio3 minio4
1
EOF
        ;;
    3)
        echo "Deploying Node 3"
        sh install.sh <<EOF
y
7
2
zookeeper3 kafka3 elasticsearch3
1
EOF
        ;;
    *)
        echo "Invalid option. Usage: $0 {1|2|3}"
        exit 1
        ;;
esac

mv -f /etc/iptables.up.rules  /etc/iptables.up.rules.bak
bash /opt/cnwaf/package/runtime/system/firewall/iptables-init.sh stop

# 修改clickhouse配置
sed -i '/<default>/a \            <max_parser_depth>2000</max_parser_depth>' /opt/cnwaf/package/runtime/clickhouse/config/clickhouse-config-ch1/users.xml

sh /opt/cnwaf/start.sh