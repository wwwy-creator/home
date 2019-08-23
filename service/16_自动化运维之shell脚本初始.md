## 脚本语言
	脚本语言(script language)
	相对于编译型语言而言
	语言编写——>编译——>链接——>运行
	缩减编译型语言的过程

	底层处理数据：字节/整数/浮点数/机器层的对象

	C、C++，Java，C#编译型


	脚本语言执行一般为解释性语言，通过解释器读入脚本程序，转为内部形式进行执行
	解释器本身就是一个编译型的程序




## shell脚本
	shell脚本语言是linux/unix系统上的雨中重要的脚本语言，在*nix领域运用极为广泛，通过shell脚本语言可以讲繁琐的事情简单实现


## shell脚本优势
	简单，易学，适合处理文件和目录之类的对象
	以简单的方式完成复杂的操作
		1.语法和结构通常比较简单
		2.学习和使用通常比较简单
		3.通常以容易修改程序的“解释”作为运行方法，不需要“编译”
		4.程序的开发产能优于运行效能



	#脚本语言的执行效率不如编译型语言




## 编写自己的第一个脚本
	
	shell脚本的基本元素
	

	[root@server0 ~]# cat everyday.sh 
	#!/bin/bash
	cd 
	. .bash_profile
	date
	who
	[root@server0 ~]# 


	#!	符号称为"sha-bang"符号，是shell脚本的起始符号
	#！	符号是指定一个文件类型的特殊标记，它告诉linux系统这个文件执行需要指定	一个解释器
	#！	符号之后是一个路径，这个路径指明解释器在系统中的位置

	shell脚本语言解释器一般为bash/sh     sed/awk

	

	命令是shell脚本的基本元素，命令通常由命令名称，选项，参数三部分组成

	

	# 仪式感   打印属于shell脚本的hello world
	[root@server0 programe]# vim hello.sh
	[root@server0 programe]# 
	[root@server0 programe]# 
	[root@server0 programe]# 
	[root@server0 programe]# chmod u+x hello.sh 
	[root@server0 programe]# ./hello.sh 
	Hello World
	[root@server0 programe]# echo $?
	0
	[root@server0 programe]# cat hello.sh 
	#!/bin/bash
	# #代表注释.
	#This is shell script first programe.
	#This program is print "Hello world".
	#Author:daochang
	#Date:"2018-11-28"
	#Version:0.1
	
	echo "Hello World"
	
	
	exit 0
	[root@server0 programe]# 



## 执行shell脚本
	1.赋予权限，直接运行脚本
		chmod u+x  *.sh
		./*.sh
	2.没有权限，通过bash或sh运行

		bash  *.sh
		sh   *.sh

	3.没有权限，通过source 或者 .  运行脚本
		source *.sh
		.  *.sh



	不同执行方法的区别在于，赋予脚本权限后直接运行脚本将在用户当前shell下开启一个新的子进程，并在子进程中运行脚本程序
	通过bash命令加载并执行，此时系统将不在关心#!后面的解释器，而是直接使用bash作为解释器解释脚本内容并执行
	通过 .  或source方法执行脚本，则脚本将在用户当前shell环境下运行




## 练习
	
	#制作程序菜单
	[root@server0 programe]# cat menu.sh 
	#!/bin/bash
	#This is a meun script
	clear
	#清空屏幕
	echo "*****************************************"
	echo -e "*\033[1;31m\t\tMenu\t\t\033[0m\t*"
	#echo -e 开启转义功能
	#\033[1,31m  颜色输出  1为样式与前景色，31为字体颜色   \033[0m  关闭颜色设置
	echo "*****************************************"
	echo "1.Display system CPU info and system load"
	echo "2.Display system Men info and swap info"
	echo "3.Display filesystem mount info"
	echo "4.Display system network interface info"
	echo "5.EXIT"
	[root@server0 programe]# 




	#统计基本信息
	#利用命令堆积方式，对囧啊本排版格式不做任何处理

	[root@server0 programe]# cat sysinf.sh 
	#!/bin/bash
	#This script can be used to collect system basic infomation.
	echo "………………………………………………………………………………………………………………………………"
	echo "Display CPU info"
	echo $(cat /proc/cpuinfo  | grep 'model name')
	echo "………………………………………………………………………………………………………………………………"
	echo "Display system load!"
	echo $(uptime)
	echo "………………………………………………………………………………………………………………………………"
	echo "Display  swap info:"
	echo $(free | grep wap)
	echo "………………………………………………………………………………………………………………………………"
	echo "Display filesystem mount info"
	echo $(df -hT | grep 'boot')
	echo "………………………………………………………………………………………………………………………………"
	echo "Display network interface info:"
	echo $(ip addr show| grep inet)
	echo "………………………………………………………………………………………………………………………………"



	#利用变量
	#打印环境变量
	[root@server0 programe]# cat aver.sh 
	#!/bin/bash
	#
	#利用$可以在脚本中引用环境变量
	echo "user info for userid:$USER"
	echo UID:$UID
	echo HOME:$HOME
	[root@server0 programe]# 




	#添加用户变量
	[root@server0 programe]# cat user_var.sh 
	#!/bin/bash
	#test variables
	days=10
	guest='dana'
	echo "$guest checked in $days days ago"
	days=5
	guest="huanglaobam"
	echo "$guest checked in $days days ago"
	[root@server0 programe]# 


	



	[root@server0 programe]# vim user_var2.sh 
	[root@server0 programe]# source user_var2.sh 
	result is 10
	[root@server0 programe]# cat user_var.sh 
	#!/bin/bash
	#test variables
	value1=10
	value2=$value1
	
	echo The result value is $value2
	[root@server0 programe]# cat user_var2.sh 
	#!/bin/bash
	a=10
	b=$a
	echo result is $b
	[root@server0 programe]# 




	#反引号
	shell脚本中反引号，
	反引号允许将shell命令的输出赋值给变量
	准确的说，必须将整个命令用反引号包围起来
	
	[root@server0 programe]# cat fanyinhao.sh 
	#!/bin/bash
	test=`date`
	echo $test
	[root@server0 programe]# 



	#使用反引号捕捉当前日期，并用他在脚本中创建唯一的文件名
	[root@server0 programe]# cat fyh.sh 
	#!/bin/bash
	#copy the /usr/bin listing to a log file
	today=`date +%y%m%d`
	echo today is $today
	ls -la /usr/bin > log.$today
	[root@server0 programe]# 



	#数学计算
	[root@server0 programe]# cat math1.sh 
	#!/bin/bash
	#an example of using the expr comand
	var1=10
	var2=20
	var3=`expr $var2 / $var1`
	echo The reslut is $var3
	[root@server0 programe]# 


	#利用括号进行数学运算
	[root@server0 programe]# cat math2.sh 
	#!/bin/bash
	var1=10
	var2=50
	var3=45
	var4=$[$var1*($var2-$var3)]
	echo The reslut is $var4
	[root@server0 programe]# 

	#利用bc进行数学运算
	[root@server0 programe]# cat math3.sh 
	#!/bin/bash
	var1=`echo "scale=4;3.44 / 5" | bc`
	echo The result is $var1
	[root@server0 programe]# 




	#
	[root@server0 programe]# cat math4.sh 
	#!/bin/bash
	var1=10
	var=3.1415936
	var3=`echo "scale=4;$var1*$var1" | bc`
	var4=`echo "scale=4;$var3*$var2"| bc`
	echo The reslut is $var4
	[root@server0 programe]#




	#EOF文本字符串表明内置重定向数据的开始和结尾
	[root@server0 programe]# cat  math5.sh 
	#!/bin/bash
	var1=10.55
	var2=3.66
	var=32.4
	var4=98
	var5=`bc << EOF
	scale=4
	a1=($var1*$var2)
	b1=($var3*$var4)
	a1+b1
	EOF
	`
	echo The final reslut is $var5
	[root@server0 programe]# 





	#退出状态    $?
	[root@server0 programe]# cat exit_status.sh 
	#!/bin/bash
	#test the exit status
	var1=10
	var2=30
	var3=$[$var1*$var2]
	echo The reslut is $var3
	exit $var3
	[root@server0 programe]# 




	#退出状态码最高255
	0-255
	通过模计算得到状态码
	一个值的模是除操作之后余数，运算结果就是哪个特定的数被256除了之后的余数，本例结果为300





## shell脚本的注意事项
	1.开头解释器  #!/bin/bash
	2.语法缩进，使用四个空格
	3.多加注释
	4.命名规则：变量名大写，函数名小写，命名要有意义
	5.默认变量是全局的，在函数中变量local指定为局部变量
	6.一定先测试在投入到生产环境
	
