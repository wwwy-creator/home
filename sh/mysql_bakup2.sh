#########################################################################
# File Name: mysql_bakup2.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月18日 星期四 21时31分54秒
# Description:  
#########################################################################
#!/bin/bash
DBPATH=/server/backup
MYUSER=
MYPASS=
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET"
[ ! -d $DBPATH ] && mkdir -p $DBPATH
for dbname in `$MYCMD -e "show databases;"|sed '1,2d'|egrep -v "mysql|schema"`
do
   mkdir $DBPATH/${dbname}_$(date +%F) -p
   for table in `$MYCMD -e "show tables from $dbname;"|sed '1d'`
   do
    $MYDUMP $dbname $table|gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}_${table}.sql.gz
   done
done
