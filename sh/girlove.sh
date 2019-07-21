#########################################################################
# File Name: girlove.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月18日 星期四 21时57分15秒
# Description:  
#########################################################################
#!/bin/bash
# http://oldboy.blog.51cto.com
girlname="$1"

pos_stdy="$(($(stty size|cut -d '' -f1)/3*2))"

pos_stdx="$(($(stty size|cut -d' '-f2)/2))"

total_stdy="$(($(stty size|cut -d'' -f1)))"

total_stdx="$(($(stty size|cut -d'' -f2)))"

logo="本节目为北京老男孩IT教育出品，祝天下所有有情人钟情眷属！"

good="${girlname},你太棒了，完美答对！"

decl="这辈子最疯狂的事，就是爱上了你，我会好好爱你的，请让我守候你一辈子！"

info="亲，$girlname, 这是我送给你的最特别礼物，请选择A-D并按下回车开始答题吧."

head="答题进度："

[ -f ./girlLove.txt ]||exit 1

. ./girlLove.txt

 

function usage(){

  echo $"Usage:$0 mm_name"

  exit 1

}

 

function start(){

# 设置红色背景

printf "\e[40m"

# 清屏

clear

printf "\r\e[10;30H\E[33m${logo}\E[0m\n"

sleep 2

printf "\r\e[10;30H\E[33;5m${logo}\E[0m\n"

sleep 2

printf "\e[40m"

clear

}

function print_xy(){

   if [ $# -eq 0 ]; then

       return 1

   fi

 

   len=32

   

   if [ $# -lt 2 ]; then

     pos="\e[${pos_stdy};$((${pos_stdx} - ${len}))H"

   fi

 

   case "$2" in

     -)

       pos="\e[$((${pos_stdy} - $3));$((${pos_stdx} - ${len}))H"

       ;;

     +)

       pos="\e[$((${pos_stdy} + $3));$((${pos_stdx} - ${len}))H"

       ;;

 

     lu)

       pos="\e[$((${pos_stdy} - $3));$((${pos_stdx} - $4))H"

       ;;

     ld)

       pos="\e[$((${pos_stdy} + $3));$((${pos_stdx} - $4))H"

   esac

   echo -ne "${pos}$1"

}

function waiting(){

  local i=1

  # 通过while循环实现///转圈的动画效果

  while [ $i -gt 0 ]

  do

       for j in '-' '\\' '|' '/'

       do

            # 打印前面若干个/特效符号+decl变量中的内容

            echo -ne"\033[1m\033[$pos_stdy;$((${pos_stdx}/3))H$j$j$j\033[4m\033[32m${decl}"

            # 打印后面若干个/特效符号

            echo -ne"\033[24m\033[?25l$j$j$j"

            # 打印前面若干个/特效符号+good变量中的内容

            echo -ne "\033[1m\033[$(($pos_stdy-2));$((${pos_stdx}/3))H$j$j$j\033[4m\033[32m${good}"

            # 打印后面若干个/特效符号

            echo -ne"\033[24m\033[?25l$j$j$j"

            usleep 100000

       done

       ((i++))

   done

}

function print_info(){

# 打印如下字符串（格式化界面）

print_xy"*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*&*"

print_xy"\E[33m${info}\E[0m"  + 1

 

 

offset=20

seq=0

# 循环问题

while [ ${seq} -lt ${#poetrys[@]} ]

do

   sleep 0

   isanswers=0

 

   # 打印问题

   print_xy "${questions[$seq]}" ld 2 $offset

   print_xy "${bakans[$seq]}" ld 3 $((${offset}-2))

   print_xy "答：" ld 4 $offset

 

   # 读取终端输入到变量ans

   read ans

   echo -e "\033[3A\r\033[K"

   # 清除问题选项行字符

   echo -e "\033[K"

   # 清除回答栏字符

   echo -e "\033[K"

   # 如果输入的值和预设的答案不同，则继续循环该问题

  if [ "$ans" != "${answers[$seq]}" -a "`echo$ans|tr a-d A-D`" != "${answers[$seq]}" ]; then

 

       # 打印 -----，格式化界面。----- 下面会显示该问题的tip

       print_xy"-----------------------------------------------------" + 5

 

       # 显示该问题的tip

       print_xy "${tips[$seq]}" + 7

       sleep 3

       # 将光标移到行首，并清除光标到行尾的字符

       echo -e "\r\033[K"

       # 光标上移3行，并清除光标到行尾的字符

       echo -e "\033[3A\r\033[K"

       continue

   fi

 

   # 问题序号 + 1

   seq=`expr ${seq} + 1`

   # 获取poetrys的倒数第seq + 1行

   curseq=`expr ${#poetrys[@]} - ${seq}`

   # 打印poetrys的倒数第seq + 1行

   print_xy "${poetrys[${curseq}]}" lu $seq $offset

   # 打印进度条

   total=$[${total_stdx} - ${#head}*10]

   per=$[${seq}*${total}/${#poetrys[@]}]

   shengyu=$[${total} - ${per}]

   printf"\r\e[${total_stdy};19H${head}\e[43m%${per}s\e[41m%${shengyu}s\e[00m""" "";

done

      printf "\r\e[$((${total_stdy}));19H \E[33m     恭喜我心中最美的${girname}全部答对\E[0m";

# 设置红色背景

printf "\e[41m"

# 清屏

clear

}

 

function main(){

if [ $# -ne 1 ]; then

 usage

fi

start

clear

print_info

waiting

}

main $*
