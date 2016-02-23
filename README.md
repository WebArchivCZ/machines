# Machines of National Library of the Czech republic

This repository contains code of Web archiving and URN:NBN Resolver infrastructure. We will recreate all production machines into this repository. It will easen our developement > testing > staging > production workflow, improve documentation and makes our lives better in general

Packer, Vagrant and Ansible are sources of magic. Packer enables us to build VM images, Vagrant makes deployment easy peasy and Ansible provision our enviroment. Right now we use bento/centos-7.2 image, but we will prepare our basic box later based on bento code.

#### Prerequisities
Vagrant 1.8.1  
ansible 2.0.0.2

#### TODO: 
Prepeare dev stage without credentials for developers withou access to VAULT_PASSWORD.  
Inspiration for different stages configuration: http://rosstuck.com/multistage-environments-with-ansible/, http://future500.nl/articles/2014/05/how-to-use-ansible-for-vagrant-and-production/, http://www.erikaheidi.com/blog/configuring-a-multistage-environment-with-ansible-and-vagrant  
Automate admin passwords hashes into vault encrypted shared/encrypted/admin_name file.

### Installation

#### If you are OSX consumer

brew install vagrant ansible

#### If you are Linux consumer

whatever install vagrant ansible

#### If you are Windows consumer, Bill with you!

You are on your own, but general idea is run ansible from VM, vagrant works from windows ok: http://www.thisprogrammingthing.com/2015/using-ansible-with-vagrant-and-windows/

### Usage

#### Running WA infrastructure on your notebook
```
git clone https://github.com/WebArchivCZ/machines.git  
cd machines/project_dir  
export VAULT_PASSWORD="Secret_password_is_shared_among_NLCR_admins_and_other_good_folks"
vagrant up
```

### Tips

#### shared dir is not project dir
It just keeps some common stuff such as public keys and ansible vault encrypted user passwords

#### Sudo under admin user
Admins have rights to sudo, as they are part of the wheel group. But each admin have to provide password for ansible by running.
```
python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"
```
and giving output into shared/encrypted/admin_name. *This file have to be encrypted with Ansible Vault using shared password*.
```
ansible-vault encrypt shared/encrypted/admin_name
```
see: http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module and http://docs.ansible.com/ansible/user_module.html
