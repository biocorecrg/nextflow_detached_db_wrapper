#!/bin/bash

set -ueo pipefail

# MySQL containerized instance

MYSQLIMG=$1
MYSQLDIR=$2
MYSQLCNF=$3
IPFILE=$4
PROCESSFILE=$5
MYSQLUSR=$6
MYSQLPWD=$7
MYSQLPORT=$8
RSTRING=$9
MYSQLDB=${10:-}

# Create instance random name for avoiding clashes
INSTANCE=mysql_${RSTRING}

mkdir -p $MYSQLDIR
mkdir -p $MYSQLDIR/db
mkdir -p $MYSQLDIR/socket

# Create DB
singularity exec -B $MYSQLDIR/db:/var/lib/mysql -B $MYSQLCNF:/etc/mysql/conf.d/custom.cnf $MYSQLIMG mysql_install_db

# Execute DB
hostname -I | perl -lne 'if ( $_=~/^(\S+)\s/ ) { $_=~/^(\S+)\s/ ; print $1; }' > $IPFILE

# mysql.ip will be dbhost
# dbuser, dbpass and dbport from config

singularity instance start -B $MYSQLDIR/db:/var/lib/mysql -B $MYSQLCNF:/etc/mysql/conf.d/custom.cnf -B $MYSQLDIR/socket:/run/mysqld $MYSQLIMG $INSTANCE

sleep 60

singularity exec instance://$INSTANCE mysql -uroot -h127.0.0.1 -P$MYSQLPORT -e "GRANT ALL PRIVILEGES on *.* TO '$MYSQLUSR'@'%' identified by '$MYSQLPWD' ;"

if [ ! -z "$MYSQLDB" ]
then
	singularity exec instance://$INSTANCE mysql -uroot -h127.0.0.1 -P$MYSQLPORT -e "CREATE DATABASE $MYSQLDB ;"
fi

# Create $PROCESSFILE here
date > $PROCESSFILE

# Do some work here...


while [ -f $PROCESSFILE ];
do
	echo $PROCESSFILE
	sleep 10;
done;

singularity instance stop $INSTANCE
exit 0
