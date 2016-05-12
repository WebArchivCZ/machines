# This is Apache role for Ansible

## Info

This is build for CentOS/Redhat. Documentaion for further work: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/ch-Web_Servers.html

## Available variables
ServerAdmin {{ apache_contact }}
DocumentRoot "{{ apache_www }}"
ServerName {{ apache_hostname }}
