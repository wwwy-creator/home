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
     

	


	