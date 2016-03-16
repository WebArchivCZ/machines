#! /usr/bin/env bash

WORK_DIR=`pwd`
TMP_DIR="$WORK_DIR/tmp"

mkdir $TMP_DIR
cd $TMP_DIR

git clone https://github.com/CentOS/CentOS-Dockerfiles.git


ln -s $TMP_DIR/CentOS-Dockerfiles/postgres/centos7 postgres


wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u72-b14/jdk-7u72-linux-x64.tar.gz"

wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.8/bin/apache-tomcat-7.0.8.tar.gz


cp "$WORK_DIR/Dockerfile" .
docker build --rm=true -t urn_nbn_resolver .

cd $WORK_DIR
# rm -r $TMP_DIR
