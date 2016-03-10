FROM centos:centos7

RUN yum -y update; yum clean all
RUN yum -y install sudo epel-release; yum clean all

# Copy and run installation scripts
ADD ./install_tomcat.sh /usr/bin/install_tomcat.sh
ADD ./install_resolver.sh /usr/bin/install_resolver.sh
RUN chmod +x /usr/bin/install_tomcat.sh
RUN chmod +x /usr/bin/install_resolver.sh
RUN /usr/bin/install_tomcat.sh
RUN /usr/bin/install_resolver.sh

# Create directory with configuration, which will be mounted from the host
RUN mkdir /etc/resolver
