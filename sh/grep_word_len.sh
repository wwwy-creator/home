#########################################################################
# File Name: grep_word_len.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月18日 星期四 21时34分24秒
# Description:  
#########################################################################
#!/bin/bash
chars="I am oldboy teacher welcome to oldboy training class"
echo $chars|awk '{for(i=1;i<=NF;i++) if(length($i)<=6)print $i}'
