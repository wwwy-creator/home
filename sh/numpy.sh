#########################################################################
# File Name: numpy.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月18日 星期四 21时54分40秒
# Description:  
#########################################################################
#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
HTMLFILE=/home/oldboy/html
HTTP=http://oldboy.blog.51cto.com/all/2561410
NUM=$(curl $HTTP |awk -F "[ /]" '/页数/ {print $(NF-3)}')
[ -d $HTMLFILE ]||mkdir $HTMLFILE -p
echo -e "<b><h1>老男孩51CTO博客文章html整理版</h1></b>\n<b><h3>老男孩教育运维脱产班31期  王梅西</h3></b>" >$HTMLFILE/blog_oldboy_$(date +%F).html
for((i=$NUM;i>0;i--))
do
    curl $HTTP/page/$i|egrep "<li><span>|<em"|awk '{if(NR%2==0){printf $0 "\n"}else{printf $0}}'|awk -F '["<>]+' '{print "<a href=\"http://oldboy.blog.51cto.com"$9"\">",$14,$10,"</a> <br>"}'|sort -n >>$HTMLFILE/blog_oldboy_$(date +%F).html
done
