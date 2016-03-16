#! /usr/bin/env bash

WORK_DIR=`pwd`
cd /tmp

git clone https://github.com/kirillF/centos-tomcat.git
git clone https://github.com/CentOS/CentOS-Dockerfiles.git

cd $WORK_DIR

ln -s /tmp/centos-tomcat tomcat
ln -s /tmp/CentOS-Dockerfiles/postgres/centos7 postgres

# rm tomcat
# rm postgres
# rm -r /tmp/centos-tomcat
# rm -r /tmp/CentOS-Dockerfiles
