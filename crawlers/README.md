# Vagrant enviroment for Crawlers

This is Playbook for crawlers in production. It does not provide testing VMs yet. Credentials for Heritrix are encrypted.

#### Usage
there should be seeds.txt in files/
there is template for crawler-beans.cxml templates/

```
ansible-playbook site.yml
```

#### TODO: 
a.) Make it a role
b.) Make more tests
c.) deal with variables in more clever way
d.) prepare development/testing scenerio
