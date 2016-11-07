# Webarchiv.cz infrastructure

This repository should build whole web archiving infrastructure of Natinoal Library with one command. WWW, Seeder, Heritrix and Openwayback should work, rest si to come. VM building with packer is not implemented yet. Stay tuned.

With developmment inventory you build vagrant machines, with production inventory you are terraforming production.

Packer, Vagrant and Ansible are sources of magic. Packer enables us to build VM images, Vagrant is for unified develepment and testing. Ansible glue it all together.

## Installation

### Prerequisities
Vagrant 1.8.1
Ansible 2.1.1
Packer
git

### OSX consumers
Using homebrew as package manager: http://brew.sh

```
brew cask install vagrant virtualbox
brew install ansible git
```

### Linux consumer
choose your flavour of package manager and pray for repo

zypper/yum/apt-get install vagrant ansible git

### Windows consumer, Bill with you!

You are on your own, but general idea is run ansible from VM, vagrant should works from windows ok: http://www.thisprogrammingthing.com/2015/using-ansible-with-vagrant-and-windows/

## Running WA infrastructure on your notebook
Code below will create two vagrant machines, with all services we provide. Services will be available on 192.168.200.10 or 192.168.200.11 You can ssh into machine using ```vagrant ssh vagrant00``` or ```vagrant ssh vagrant01```
```
git clone https://github.com/webarchivcz/machines.git
cd machines
vagrant up
```

#### Provision machines after playbook updates
```
vagrant provision
```
or 
```
ansible-playbook playbook-to-be-played.yml
```

#### Destroy whole enviroment
```
vagrant destroy
```

## Vagrant tips

If you up/destroy you VMs a lot, create ~/.ssh/config for your local vagrant machines. Tip is from: http://hakunin.com/six-ansible-practices#path-to-success. Do not do this for staging/production!
```
# For vagrant virtual machines
Host 192.168.200.1* vagrant0*
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
  User vagrant
  LogLevel ERROR
```
## Way of Operation

### Default variables
Default variables are used for development stage in vagrant. They are stored in roles/$role_name/defaults/main.yml or group_vars/all. Even credentials are stored as plaintext, so anyone can see them or change them.

### Production variables
Common variables for production environment are kept in group_vars/production. Name of our admin logins is publicly available vars.yml, in AES-256 encrypted vault.yml we keep hashes of our passwords and our public keys. We should also keep IP address of environment vaulted.<
or host_vars. 

## Production notes

### Darkest secrets
Development machines use default credentials for each service. But for production our darkest secrets such as passwords are stored in ansible-vault files. Ansible vaults are encrypted using AES-256. We do even encrypt public keys.

Admins have rights to sudo, as they are part of the wheel group. But each admin have to provide password for ansible using argument --ask-sudo-pass. User configuration is stored in role/common/vars and secrets in role/common/vault. You should define vault_user_pass using output of:
```
python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"
```
see: http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module and http://docs.ansible.com/ansible/user_module.html


## Workhorses

### Crawlers

### Description
For harvest time we use Heritrix 3

#### Usage
there should be seeds.txt in files/
there is template for crawler-beans.cxml templates/

### Indexers

## Apps for curators
### seeder 

#### basic info
repo: https://github.com/webarchivcz/seeder succeeds WAdmin (https://github.com/webarchivcz/wa-admin)

#### description
seeeder helps to manage work with legal deposit

#### implementation description
django + postgresql + elasticsearch + memcached + python 3

uwsgi in emperor mode, tyrant is overthrown, uwsgi.d:
  seeder.ini

/opt/virtualenv/seeder

manage.py legacy\_sync migrates old WAadmin MySQL database to PostgreSQL.

#### todo
Mails
Make manage.py superuser idempotent
Automatic passwords for superusers
external logging
*Sentry*: https://github.com/getsentry/sentry
elasticsearch\_plugins is broken

### wa-kat
repo: https://github.com/webarchivcz/WA-KAT | Assisted catalogization tool

#### basic info

#### description

#### implementation
python 2.7, zeo database

supervisord.d:
  zeo.ini
  wa-kat.ini

#### todo
run behind nginx

Enforce style and consistency in: tagging; whitespace; Naminng of Tasks, Plays, Variables, Roles ; Directory layouts. For variables, prefix should be role name., write to confs: '{{ ansible_managed | comment }}' ; ansible roles to specific version or tag
