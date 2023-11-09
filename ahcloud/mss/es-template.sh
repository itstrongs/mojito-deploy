curl -XPUT "http://es1.ahcloud-private.com:9201/_template/mss_el_template" -H 'Content-Type: application/json' -d '{
"order": 0,
"index_patterns": [
    "dp_mss_rule_model*"
],
"settings": {
    "index": {
    "mapping": {
        "ignore_malformed": "true"
    },
    "refresh_interval": "60s",
    "number_of_shards": "10",
    "translog": {
        "sync_interval": "30s",
        "durability": "async"
    },
    "number_of_replicas": "1"
    }
},
"mappings": {
    "include_in_all": false,
    "dynamic_templates": [
    {
        "fields_time": {
        "mapping": {
            "type": "date"
        },
        "match": "timestamp"
        }
    },
    {
        "detail_fields_time": {
        "path_match": "message.collectorReceiptTime",
        "mapping": {
            "format": "yyyy-MM-dd HH:mm:ssZ",
            "type": "date"
        }
        }
    },
    {
        "detail_fields_time": {
        "path_match": "message.startTime",
        "mapping": {
            "format": "yyyy-MM-dd HH:mm:ssZ",
            "type": "date"
        }
        }
    },
    {
        "alarmJson.attrs": {
        "path_match": "alarmJson.*",
        "mapping": {
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    },
    {
        "tags.attrs": {
        "path_match": "tags.*",
        "mapping": {
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    },
    {
        "detail_info": {
        "mapping": {
            "index": false,
            "type": "text"
        },
        "match": "detail_info"
        }
    },
    {
        "message.attrs": {
        "path_match": "message.*",
        "mapping": {
            "ignore_above": 10240,
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    },
    {
        "String.fields": {
        "mapping": {
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    }
    ],
    "properties": {
    "alarmJson.extend_column": {
        "index": false,
        "type": "text"
    },
    "extend_column": {
        "index": false,
        "type": "text"
    }
    },
    "date_detection": true
},
"aliases": {
    "dp_mss_rule_model_output_all": {}
}
}' --user elastic:elastic@default


curl -XPUT "http://es1.ahcloud-private.com:9201/_template/mss_el_template2" -H 'Content-Type: application/json' -d '{
"order": 0,
"index_patterns": [
    "dp_all_mss_ailpha_alert_output_*"
],
"settings": {
    "index": {
    "max_result_window": "50000",
    "mapping": {
        "ignore_malformed": "true"
    },
    "refresh_interval": "60s",
    "number_of_shards": "10",
    "translog": {
        "sync_interval": "30s",
        "durability": "async"
    },
    "number_of_replicas": "1"
    }
},
"mappings": {
    "include_in_all": false,
    "dynamic_templates": [
    {
        "fields_time": {
        "mapping": {
            "type": "date"
        },
        "match": "timestamp"
        }
    },
    {
        "detail_fields_time": {
        "path_match": "message.collectorReceiptTime",
        "mapping": {
            "format": "yyyy-MM-dd HH:mm:ss",
            "type": "date"
        }
        }
    },
    {
        "detail_fields_time": {
        "path_match": "message.startTime",
        "mapping": {
            "format": "yyyy-MM-dd HH:mm:ss",
            "type": "date"
        }
        }
    },
    {
        "detail_fields_time": {
        "path_match": "message.endTime",
        "mapping": {
            "format": "yyyy-MM-dd HH:mm:ss",
            "type": "date"
        }
        }
    },
    {
        "tags.attrs": {
        "path_match": "tags.*",
        "mapping": {
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    },
    {
        "detail_info": {
        "mapping": {
            "index": false,
            "type": "text"
        },
        "match": "detail_info"
        }
    },
    {
        "message.attrs": {
        "path_match": "message.*",
        "mapping": {
            "ignore_above": 10240,
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    },
    {
        "alarmJson.attrs": {
        "path_match": "alarmJson.*",
        "mapping": {
            "ignore_above": 10240,
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    },
    {
        "String.fields": {
        "mapping": {
            "type": "keyword"
        },
        "match_mapping_type": "string"
        }
    }
    ],
    "properties": {
    "alarmJson.extend_column": {
        "index": false,
        "type": "text"
    },
    "extend_column": {
        "index": false,
        "type": "text"
    }
    },
    "date_detection": true
},
"aliases": {
    "dp_all_mss_ailpha_alert_output": {}
}
}' --user elastic:elastic@default