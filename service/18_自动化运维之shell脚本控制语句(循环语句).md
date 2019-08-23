# 循环语句应用
	- 在日常工作中需要重复运行大量的指令，shell提供了for，while，until，select循环语句以实现特定环境下特定指令的反复利用
	- 每次运行命令序列时都要对条件进行过滤，满足条件才可执行


## for循环
	#语法格式一：
	for 变量 in 值1 值2 ……值N
	do
	命令序列
	done

	#变量通过赋值in里面的值，多个赋值用空格隔开

	#语法格式2：
	for ((初始变量值;结束循环条件;运算))
	do
	命令序列
	done



## for循环案例
	#给多个客户批量发送邮件
	mail -s  ”标题“  xx@qq.com   <  /neirong


	#!/bin/bash
	DOMAIN=163.com
	for MAIL_USER in dana  dahuang dalv
	do
	mail -s "LOG" $MAIL_USER@$DOMAIN < /var/log/messages
	echo "$MAIL_USER 邮件发送成功"
	done



	#利用for循环打印九九乘法表
	#!/bin/bash
	for i in {1..9}
	do
	        for ((j=1;j<=i;j++))
	        do
	        printf "%-8s" $j*$i=$((j*i))
	        done
	        echo 
	done




## while循环语句
	
	语法格式一：
	while [条件]
	do
	命令序列
	done



	语法格式2
	while read -r  line
	do
	命令序列
	done  <  file


	#通过read命令每次读取一行文件，文件内容有多少行，while循环多少次



## while循环练习
	
	#批量添加20个用户，用户名为 TLN，N为1-20编号
	
     
	[root@server0 programe]# cat add_user.sh 
	#!/bin/bash
	# Add twenty users  with while
	
	NUM=1
	while [ $NUM -le 20 ]
	do
		#userdel -r TL${NUM}   #删除用户时，注意添加-r选项
	    useradd TL${NUM}
	    echo TL${NUM}“创建成功”
	    ID=`id TL${NUM}`
	    echo TL${NUM}"用户的UID号为"${ID}
	    NUM=$((NUM+1))
	done
	[root@server0 programe]# 


	#打印网卡配置文件
	[root@server0 programe]# cat read_nic.sh 
	#!/bin/bash
	#read nic file
	
	FILE=/etc/sysconfig/network-scripts/ifcfg-eno16777728
	
	while read -r line
	do
	echo $line
	done < $FILE
	[root@server0 programe]# 



	#无限循环菜单，根据用户选择实现不同的菜单功能，最后退出脚本
	[root@server0 programe]# cat new_menu.sh 
	#!/bin/bash
	while true     #无限循环
	do
	clear
	echo "…………………………………………………………………………………………"
	echo "1.Display CPU info:"
	echo "2.Display system load:"
	echo "3.Display Mem and swap info:"
	echo "4.Display filesytem mount info:"
	echo "5.Exit Program"
	echo "…………………………………………………………………………………………"
	read -p "plese select your iterm(1-5):" U_SELECT
	case $U_SELECT in
	    1)
		echo $(cat /proc/cpuinfo)
		read -p "plese enter to continue:"
		;;
	    2)
		echo $(uptime)
		read -p "plese enter to continue:"
		;;
	    3)
		echo $(free)
		read -p "plese enter to continue:"
		;;	
	    4)
		echo $(df -hT)
		read -p "plese enter to continue:"
	        ;;
	    5)
		exit 0
	        ;;
	    *)
		read -p "plese select 1-5,Press Enter to continue:"
	esac
	done
	[root@server0 programe]# 
	








## until
	
	语法格式
	until [条件]
	do
	命令序列
	done

	#该语句根据条件判断循环是否继续，until代表的是知道满足条件时循环结束


	#批量删除用户
	[root@server0 programe]# cat del_user.sh 
	#!/bin/bash
	#delete user
	NUM=20
	until [ $NUM -eq 0 ]
	do
	    userdel -r TL${NUM}
	    echo "user  TL${NUM} delete ok!"
	    NUM=$((NUM-1))
	done
	[root@server0 programe]# 

	



## select语句
	select用来生成菜单工具
	select循环与for循环格式相同

	#select生成籍贯提问菜单，并通过echo回显
	[root@server0 programe]# cat select_p.sh 
	#!/bin/bash
	echo "Where are you from?"
	select var in 'BJ' 'CD' 'DH'  'CQ' 'TJ'  'LZ' 'NY'
	do
	break
	done
	echo "You are from $var"
	[root@server0 programe]# 



	