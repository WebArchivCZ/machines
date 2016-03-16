#! /usr/bin/env bash

# instalace apache tomcatu
# source: https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-7-on-centos-7-via-yum
yum -y install tomcat httpd

echo 'JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"' > /usr/share/tomcat/conf/tomcat.conf

systemctl enable tomcat
systemctl start tomcat
