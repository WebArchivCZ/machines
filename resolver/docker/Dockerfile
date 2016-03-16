FROM centos:centos7

RUN yum -y update; yum clean all
RUN yum -y install sudo epel-release wget tar; yum clean all



# Install postgresql
RUN yum -y install postgresql-server postgresql postgresql-contrib supervisor; yum clean all

ADD CentOS-Dockerfiles/postgres/centos7/postgresql-setup /usr/bin/postgresql-setup
ADD CentOS-Dockerfiles/postgres/centos7/supervisord.conf /etc/supervisord.conf
ADD CentOS-Dockerfiles/postgres/centos7/start_postgres.sh /start_postgres.sh

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers
RUN chmod +x /usr/bin/postgresql-setup
RUN chmod +x /start_postgres.sh

RUN /usr/bin/postgresql-setup initdb

ADD CentOS-Dockerfiles/postgres/centos7/postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf

RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf

VOLUME ["/var/lib/pgsql"]

EXPOSE 5432

CMD ["/bin/bash", "/start_postgres.sh"]



# From http://www.dev-garden.org/2014/12/27/setting-up-a-docker-container-with-centos6-and-tomcat7/
# Install JDK7
 
#Note that ADD uncompresses this tarball automatically
ADD jdk-7u72-linux-x64.tar.gz /opt
WORKDIR /opt/jdk1.7.0_72
RUN alternatives --install /usr/bin/java java /opt/jdk1.7.0_72/bin/java 1
RUN alternatives --install /usr/bin/jar jar /opt/jdk1.7.0_72/bin/jar 1
RUN alternatives --install /usr/bin/javac javac /opt/jdk1.7.0_72/bin/javac 1
RUN echo "JAVA_HOME=/opt/jdk1.7.0_72" >> /etc/environment
 
# Install TOMCAT
 
#Note that ADD uncompresses this tarball automatically
ADD apache-tomcat-7.0.8.tar.gz /usr/share
WORKDIR /usr/share/
RUN mv apache-tomcat-7.0.8 tomcat7
RUN echo "JAVA_HOME=/opt/jdk1.7.0_72/" >> /etc/default/tomcat7
RUN groupadd tomcat
RUN useradd -s /bin/bash -g tomcat tomcat
RUN chown -Rf tomcat.tomcat /usr/share/tomcat7
EXPOSE 8080



# Copy and run installation scripts
#ADD /install_tomcat.sh /usr/bin/install_tomcat.sh
#ADD ./install_resolver.sh /usr/bin/install_resolver.sh
#RUN chmod +x /usr/bin/install_tomcat.sh
#RUN chmod +x /usr/bin/install_resolver.sh
#RUN /usr/bin/install_tomcat.sh
#RUN /usr/bin/install_resolver.sh

# Create directory with configuration, which will be mounted from the host
#RUN mkdir /etc/resolver

EXPOSE 80
EXPOSE 443
