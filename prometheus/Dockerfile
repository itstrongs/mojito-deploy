FROM docker.das-security.cn/cloudpl/library/openjdk:8u261-jre-centos-ssh

ADD jmx_prometheus_httpserver-0.19.0.jar ./
ADD config.yaml ./

ENTRYPOINT [ "java", "-jar", "jmx_prometheus_httpserver-0.19.0.jar", "12345", "config.yaml" ]