#!/bin/bash

# qsub run.mysql.qsub.sh

MYSQLIMG=$1
MYSQLDIR=$2
MYSQLCNF=$3
IPFILE=$4
PROCESSFILE=$5
MYSQLUSR=$6
MYSQLPWD=$7
MYSQLPORT=$8
RSTRING=$9
MYSQLDB=${10}

bash run.mysql.sh $MYSQLIMG $MYSQLDIR $MYSQLCNF $IPFILE $PROCESSFILE $MYSQLUSR $MYSQLPWD $MYSQLPORT $RSTRING $MYSQLDB
