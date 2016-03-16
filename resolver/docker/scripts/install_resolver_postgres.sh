#! /usr/bin/env bash

mkdir /tmp/czidlo
cd /tmp/czidlo

wget https://github.com/NLCR/CZIDLO/releases/download/v4.3.alpha/CZIDLO_4.3.alpha-installation.zip.zip
unzip CZIDLO_4.3.alpha-installation.zip.zip

psql -a -f initDatabase_4.3.alpha.sql
