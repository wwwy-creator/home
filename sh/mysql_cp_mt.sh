#########################################################################
# File Name: mysql_cp_mt.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月18日 星期四 21时41分06秒
# Description:  
#########################################################################
#!/bin/bash
###########################################
# this script function is :
# check_mysql_slave_replication_status
# USER        YYYY-MM-DD - ACTION
# oldboy      2009-02-16 - Created
############################################
path=/server/scripts
MAIL_GROUP="1111@qq.com 2222@qq.com"
PAGER_GROUP="18600338340 18911718229"
LOG_FILE="/tmp/web_check.log"
USER=root
PASSWORD=oldboy123
PORT=3307
MYSQLCMD="mysql -u$USER -p$PASSWORD -S /data/$PORT/mysql.sock"
error=(1008 1007 1062)
RETVAL=0
[ ! -d $path ] && mkdir -p $path

function JudgeError(){
for((i=0;i<${#error[*]};i++))
do
  if [ "$1" == "${error[$i]}" ]
    then
      echo "MySQL slave errorno is $1,auto repairing it."
      $MYSQLCMD -e "stop slave;set global sql_slave_skip_counter=1;start slave;"
  fi
done
return $1
}

function CheckDb(){
status=($(awk -F ': ' '/_Running|Last_Errno|_Behind/{print $NF}' slave.log))
 expr ${status[3]} + 1 &>/dev/null
 if [ $? -ne 0 ];then
    status[3]=300
 fi
 if [ "${status[0]}" == "Yes" -a "${status[1]}" == "Yes" -a ${status[3]} -lt 120 ]
  then
    #echo "Mysql slave status is ok"
    return 0
  else
    #echo "mysql replcation is failed"
    JudgeError ${status[2]}
  fi
}

function MAIL(){
local SUBJECT_CONTENT=$1
for MAIL_USER  in `echo $MAIL_GROUP`
 do
    mail -s "$SUBJECT_CONTENT " $MAIL_USER <$LOG_FILE
done
}
function PAGER(){
for PAGER_USER  in `echo $PAGER_GROUP`
do
 TITLE=$1   
 CONTACT=$PAGER_USER
 HTTPGW=http://oldboy.sms.cn/smsproxy/sendsms.action
 #send_message method1
 curl -d  cdkey=5ADF-EFA -d password=OLDBOY -d phone=$CONTACT -d message="$TITLE[$2]" $HTTPGW
done
}
function SendMsg(){
  if [ $1 -ne 0 ]
    then 
       RETVAL=1
       NOW_TIME=`date +"%Y-%m-%d %H:%M:%S"`
       SUBJECT_CONTENT="mysql slave is error,errorno is $2,${NOW_TIME}."
       echo -e "$SUBJECT_CONTENT"|tee $LOG_FILE
       MAIL $SUBJECT_CONTENT
       PAGER $SUBJECT_CONTENT $NOW_TIME
  else
      echo "Mysql slave status is ok"
      RETVAL=0
  fi
  return $RETVAL
}
function main(){
while true
do
   CheckDb
   SendMsg $? 
   sleep 300
done
}
main
