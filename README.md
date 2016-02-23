# Machines of National Library of the Czech republic

This repository contains code of Web archiving and URN:NBN Resolver infrastructure. We will recreate all production machines into this repository. It will easen our developement > testing > staging > production workflow, improve documentation and makes our lives better in general

Packer, Vagrant and Ansible are sources of this magic. Packer enables us to build VM images, Vagrant makes deployment easy peasy and Ansible provision our enviroment. Right now we use bento/cento7.2 image, but we will prepare our basic box later based on bento code.

#### Prerequisities
Vagrant 1.8.1  
ansible 2.0.0.2

#### TODO: 
Prepeare stage without credentials for developers withou access to VAULT_PASSWORD.
Prepeare different stages. Check: http://rosstuck.com/multistage-environments-with-ansible/, http://future500.nl/articles/2014/05/how-to-use-ansible-for-vagrant-and-production/, http://www.erikaheidi.com/blog/configuring-a-multistage-environment-with-ansible-and-vagrant

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
It just keeps some common stuff such as public keys and ansible vault encrypted passwords

#### set my password | admins have rights to sudo, as they are part of the wheel group - but they have to use password
shared/encrypted/admin_name should be encrypted with Ansible Vault, in encrypted file there should be your encrypted password - as output of: 
```
python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"
```
see: http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module and http://docs.ansible.com/ansible/user_module.html
