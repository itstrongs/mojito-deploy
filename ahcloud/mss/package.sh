#!/bin/sh

# mysql bin 目录
mysql_dir=/usr/local/mysql-8.0.34-macos13-arm64/bin
pkg_name="data-platform-mss"
mkdir $pkg_name

rm -rf ${pkg_name}.zip

# 导出mysql
${mysql_dir}/mysqldump --no-data -h 10.50.26.49 -P 3307 -uroot -p1qazCDE#5tgb --default-character-set=utf8 --databases data_platform \
        > ${pkg_name}/mysql-ddl.sql
${mysql_dir}/mysqldump --no-create-info -h 10.50.26.49 -P 3307 -uroot -p1qazCDE#5tgb --default-character-set=utf8 --databases data_platform \
        --ignore-table=data_platform.analysis_statistical_task_compensate \
        --ignore-table=data_platform.analysis_table_info \
        --ignore-table=data_platform.analysis_task_execute_log \
        --ignore-table=data_platform.analysis_record_log \
        --ignore-table=data_platform.task_schedule_record \
        --ignore-table=data_platform.analysis_detail_rule \
        --ignore-table=data_platform.analysis_basic_quota_table \
        > ${pkg_name}/mysql-dml.sql

cp * ${pkg_name}
zip -r ${pkg_name}.zip ${pkg_name}
rm -rf $pkg_name