use data_platform;

# 更新数据源
update data_source set endpoint='kafka1.ahcloud-private.com:9091,kafka2.ahcloud-private.com:9092,kafka3.ahcloud-private.com:9093' where type='KAFKA';
update data_source set endpoint='es1.ahcloud-private.com:9201,es2.ahcloud-private.com:9202,es3.ahcloud-private.com:9203,es4.ahcloud-private.com:9204', password = 'elastic@default' where type = 'ELASTICSEARCH';
update data_source set endpoint='mysqlm.mss-internal.com:3306', password='Fe3d9f8169190d' where type='MYSQL';
update data_source set endpoint='ch1.ahcloud-private.com:18123' where type='CLICKHOUSE';

# 更新指标
update data_manage_data_dict set status='NOT_LOADED' where deleted=0;

# 更新数据分析任务
update analysis_load_task set status='STOP', publish_status='UN_PUBLISHED' where deleted = 0;
update analysis_model_table set status='STOP', publish_status='UN_PUBLISHED' where deleted=0 and status='RUNNING' limit 1;
update analysis_quota_table set running_status='STOP', publish_status='UN_PUBLISHED' where deleted = 0;
update analysis_data_process set status='STOP', publish_status='UN_PUBLISHED' where deleted = 0;
update data_manage_data_sink set status='STOP', publish_status='UN_PUBLISHED' where deleted = 0;

# 拉起任务时，顺序问题可能导致任务异常，需要增加重试机制