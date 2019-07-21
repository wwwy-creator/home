#########################################################################
# File Name: touch_file.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月17日 星期三 09时05分23秒
# Description: 在指定文件夹下创建带有固定单词的 n 个文件，且文件名为10个随机小写字母
#########################################################################
#!/bin/bash
path=$1
word=$2
n=$3
[ -d $path ] || mkdir -p $path
for n in `seq $n`
do
        random=$(openssl rand -base64 40|sed 's#[^a-z]##g'|cut -c 2-11)
        touch $path/${random}_$word
done
