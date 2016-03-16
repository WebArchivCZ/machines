#! /usr/bin/env bash

cp /tmp/czidlo/*.war /usr/share/tomcat7/webapps

cat > /usr/share/tomcat7/conf/context.xml <<EOF
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

# systemctl restart tomcat
