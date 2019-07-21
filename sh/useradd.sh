#########################################################################
# File Name: useradd.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月17日 星期三 09时39分04秒
# Description:  
#########################################################################
#!/bin/bash
user=$1
file=$2
for num in 'seq -w 10'
do
        pass="`echo "test$RANDOM"|md5sum|cut -c 3-11`"
        useradd $user$num &> /dev/null &&\
        echo "$pass"|passwd --stdin $user$num &> /dev/null &&\
        echo -e "user:$user$num\tpasswd:$pass" >> ${file}
        if [ $? -eq 0 ]
            then
                action "$user$num is ok" /bin/true
        elese
                action "$user$num if fail" /bin/false
                                fi
done
echo ------------------------------------------------
cat $file && > $file
