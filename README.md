# Machines of National Library of the Czech republic

This is repository for Code of Web archiving infrastructure. We will build all machines from this repository. These machines will be used for developement > testing > production.

### TODO: 
make public variant developers out of NL CR.

## Installation

### If you are OSX consumer

brew install vagrant ansible

### If you are Linux consumer

whatever install vagrant ansible

### If you are Windows consumer

I do not know

## Usage

### Running WA infrastructure on your notebook
git clone https://github.com/WebArchivCZ/machines.git  
cd project_dir  
export VAULT_PASSWORD=Secret_password_who_is_shared_among_NLCR_admins_and_like_only
vagrant up

## Tips

### shared dir is not project dir
It just keeps some common stuff such as public keys and ansible vault encrypted passwords

### set my password | admins have rights to sudo, as they are part of the wheel group - but they have to use password
shared/encrypted/admin_name should be encrypted with Ansible Vault, in encrypted file there should be your encrypted password - as output of: python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"
see: http://docs.ansible.com/ansible/faq.html#how-do-i-generate-crypted-passwords-for-the-user-module and http://docs.ansible.com/ansible/user_module.html
