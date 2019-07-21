#########################################################################
# File Name: mysql_bakup.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月18日 星期四 21时28分47秒
# Description:  
#########################################################################
#!/bin/bash
#!/bin/sh
DBPATH=/server/backup
MYUSER=                 #定义数据库用户名
MYPASS=                 #定义数据库用户名密码
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET"
[ ! -d $DBPATH ] && mkdir $DBPATH
for dbname in `$MYCMD -e "show databases;"|sed '1,2d'|egrep -v "mysql|schema"`
do
  $MYDUMP $dbname|gzip >$DBPATH/${dbname}_$(date +%F).sql.gz
done
