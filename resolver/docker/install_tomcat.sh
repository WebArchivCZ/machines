#! /usr/bin/env bash

# instalace apache tomcatu
# source: https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-7-on-centos-7-via-yum
yum -y install tomcat

echo 'JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"' > /usr/share/tomcat/conf/tomcat.conf

systemctl enable tomcat
systemctl start tomcat

# instalace httpd (apache) a konfigurace pro práci s tomcatem
# source: http://www.diegoacuna.me/installing-mod_jk-on-apache-httpd-in-centos-6-x7-x/
yum -y install httpd httpd-devel apr apr-devel apr-util apr-util-devel gcc gcc-c++ make autoconf libtool wget

mkdir -p /opt/mod_jk/
cd /opt/mod_jk
wget http://www.eu.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.41-src.tar.gz
tar -xvzf tomcat-connectors-1.2.41-src.tar.gz
cd tomcat-connectors-1.2.41-src/native

./configure --with-apxs=/usr/bin/apxs
make
libtool --finish /usr/lib64/httpd/modules
make install

# konfigurace apache a tomcatu
TOMCAT_CONF=/etc/tomcat/server.xml
sed '/<Service name="Catalina">/a <Connector port="8009" protocol="AJP\/1.3" redirectPort="8443" \/>' -i $TOMCAT_CONF
sed '/<Engine name="Catalina" defaultHost="localhost">/a <Engine name="Catalina" defaultHost="localhost" jvmRoute="jvm1">' -i $TOMCAT_CONF

cat > /etc/httpd/conf.d/mod_jk.conf <<EOF
LoadModule jk_module "/etc/httpd/modules/mod_jk.so"
 
JkWorkersFile /etc/httpd/conf/workers.properties
# Where to put jk shared memory
JkShmFile     /var/run/httpd/mod_jk.shm
# Where to put jk logs
JkLogFile     /var/log/httpd/mod_jk.log
# Set the jk log level [debug/error/info]
JkLogLevel    info
# Select the timestamp log format
JkLogStampFormat "[%a %b %d %H:%M:%S %Y] "
#JkRequestLogFormat "%w %V %T"
#JkEnvVar SSL_CLIENT_V_START worker1
EOF

mkdir -p /var/run/mod_jk
chown apache:apache /var/run/mod_jk

cat > /etc/httpd/conf/workers.properties <<EOF
workers.apache_log=/var/log/httpd
worker.list=app1Worker
worker.stat1.type=status
 
worker.app1Worker.type=ajp13
worker.app1Worker.host=app1.myhost.com #put your app host here
worker.app1Worker.port=8009
EOF

cat > /etc/httpd/conf.d/app1.conf <<EOF
<VirtualHost *:80>
    ServerName resolver.nkp.cz
    ServerAdmin jaroslav.svoboda@nkp.cz
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-agent}i\"" combined
    CustomLog /var/log/httpd/app1_access.log combined
    ErrorLog /var/log/httpd/app1_error.log
    <IfModule mod_jk.c>
       JkMount /* app1Worker
    </IfModule>
</VirtualHost>
EOF

service httpd restart
