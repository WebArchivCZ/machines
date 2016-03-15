#! /usr/bin/env bash

# instalace resolveru
yum -y install unzip

chmod 777 /usr/share/tomcat/webapps

su postgres
mkdir /tmp/czidlo
cd /tmp/czidlo

wget https://github.com/NLCR/CZIDLO/releases/download/v4.3.alpha/CZIDLO_4.3.alpha-installation.zip.zip
unzip CZIDLO_4.3.alpha-installation.zip.zip

psql -a -f initDatabase_4.3.alpha.sql
cp *.war /usr/share/tomcat/webapps

cat > /usr/share/tomcat/conf/context.xml <<EOF
<Context antiJARLocking="true" path="/api">
<Resource auth="Container"
 driverClassName="org.postgresql.Driver"
 maxActive="100" maxIdle="30" maxWait="200"
 name="jdbc/postgres"
 username="testuser"
 password="testpass"
 type="javax.sql.DataSource"
 url="jdbc:postgresql://localhost:5432/czidlo_core"
 />
</Context>
EOF

systemctl restart tomcat