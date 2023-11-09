#!/bin/sh

# 执行mysql脚本
mysql -h mysqlm.mss-internal.com -uroot -P 3306 -pFe3d9f8169190d -e "CREATE DATABASE data_platform;"
mysql -h mysqlm.mss-internal.com -uroot -P 3306 -pFe3d9f8169190d < mysql-ddl.sql
mysql -h mysqlm.mss-internal.com -uroot -P 3306 -pFe3d9f8169190d < mysql-dml.sql
mysql -h mysqlm.mss-internal.com -uroot -P 3306 -pFe3d9f8169190d < mysql-init.sql

# 执行es脚本
sh es-template.sh