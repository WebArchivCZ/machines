# Apps for web archive curators

## seeder 

### basic info
repo: https://github.com/webarchivcz/seeder succeeds WAdmin (https://github.com/webarchivcz/wa-admin)

### description
seeeder helps to manage work with legal deposit

### implementation description
django + postgresql + elasticsearch + memcached + python 3
/opt/virtualenv/seeder

manage.py legacy\_sync migrates old WAadmin MySQL database to PostgreSQL.

### todo
Mails
Make manage.py superuser idempotent
Automatic passwords for superusers
external logging
*Sentry*: https://github.com/getsentry/sentry
elasticsearch\_plugins is broken

## wa-kat
repo: https://github.com/webarchivcz/WA-KAT | Assisted catalogization tool

### basic info

### description

### implementation
python 2.7, zeo database

### todo
run behind nginx
