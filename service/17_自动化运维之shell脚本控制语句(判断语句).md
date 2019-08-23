# shell脚本控制语句
	- 判断语句使用
	- 循环语句的使用




## 判断语句
	判断语句使得我们脚本更加具有活性，通过判断，可以分析当前系统环境，条件允许做某些事情，条件不允许做某些事情
	shell脚本中判断可以使用if语句和case语句



### if语句
	常用语法格式，
	条件：判断条件可以使用test命令，可以使用[]测试
	动作：命令序列，可以是一条命令，可以是多条命令
	

	#语法格式一：
	if 条件
	then	
	命令序列
	fi

	"""
	if age>=18
	then
	echo "可以去网吧啦"
	else
	echo "你妈妈叫你回家吃饭"
	fi
	"""



	#语法格式二
	if 条件
	then
	命令序列
	else
	命令序列


	#语法格式三
	if 条件
	then
	命令序列
	elif 条件
	then
	命令序列
	elif 条件
	then
	命令序列
	.
	.
	else
	命令序列
	fi




## if语句案例
	
	#要求用户输入密码，判断密码是否正确
	#!/bin/bash
	#read passwd and test.
	read -p "input a password:" passwd
	if [ "$passwd" == "123123" ]
	then
	echo "the password OK!"
	fi


	read -p "input a password:" passwd
	if [ "$passwd" == "123123" ];then
	echo "the password OK!"
	fi



	#密码错误，显示error，
	#!/bin/bash
	#read passwd and test.
	read -p "input a password:" passwd
	if [ "$passwd" == "123123" ];then
	echo "the password OK!"
	else
	echo "the passwd ERROR!"
	fi
		

	#判断当前用户是否是root用户，如果是，则执行tar备份/etc/目录
	#!/bin/bash
	#判断当前用户是否是root用户，是备份etc目录
	if [ "$(id -u)" -eq "0" ]
	then
	tar -czvf /root/etc.tar.gz /etc  &> /dev/null
	echo "backup successful!!!"
	else
	echo "plese root login~~~"
	fi



	#读参数  $1 判断成绩
	成绩小于60   显示  回家等着挨揍吧
	成绩大于或等于60但小于70     呵呵哒，算你应用及格啦
	成绩大于等于70小于80	  显示小伙还可以
	成绩大于等于80小于90    显示牛逼啊
	成绩大于等于90			上天了啊

	#!/bin/bash
	#test score print to level
	
	if [ $1 -ge 90 ];then
	echo "上天了昂"
	elif [ $1 -ge 80 ];then
	echo "牛逼啊"
	elif [ $1 -ge 70 ];then
	echo "小伙子还可以啊"
	elif [ $1 -ge 60 ];then
	echo "呵呵哒，算你走运"
	elif [ $1 -eq 100 ];then
	echo "哥们，给别人留点活路吧~~"
	else
	echo "等着回家挨揍吧~~"
	fi






## case语句
	在shell脚本中，除了使用if语句进行判断外，还可以使用case语句进行判断
	case语句实质是if多重判断语句的替换吧，易读易写
	case语句通过检查模式与变量是否相匹配，如果匹配则执行case命令序列
	*)为case默认操作，当所有的模式都未匹配时，则执行这个
	模式可以使用通配符
	模式下的命令序列必须要用;;结尾，代表该模式下的命令结束
	case        esac



	#case语句格式一
	case $变量名称  in
	模式1)
		命令序列
		;;
	模式2）
		命令序列
		;;
	.
	.
	模式N)
		命令序列
		;;
	*)
	esac



	#case语句格式2
	
	case $变量名称  in
	模式1 | 模式2)
		命令序列
		;;
	模式2 | 模式3）
		命令序列
		;;
	.
	.

	*)
	esac



	

## case语句案例
	
	#根据时间备份/var/log目录
	仅仅备份周一，周四的数据
	#!/bin/bash
	DATE=$(date +%a)
	TIME=$(date +%Y%m%d)
	
	case $DATE in Mon | Thu)
	        tar -czvf /root/${TIME}_log_tar.gz  /var/log  &> /dev/null
	        echo "${TIME}的日志备份成功~~~"
	        ;;
	*)
	        echo "Today is ${DATE}"
	esac



	#火狐浏览器自动启动脚本
	支持start stop restart
	
	#!/bin/bash
	case $1 in
	        start)
	                firefox &
	                ;;
	        stop)
	                pkill firefox
	                ;;
	        restart)
	                pkill firefox
	                firefox &
	                ;;
	        *)
	                echo "Usage:$0 (start|stop|restart)"
	esac





	#根据用户输入的参数，判断并返回相应的结果
	如果输入字符：提示你输入的是字符
	如果输入数字，提示输入的是数字
	如果提示error
	#!/bin/bash
	case $1 in
	[a-z]|[A-Z])
	echo "you have type a char:$1"
	;;
	[[:digit:]])     #判断$1是否是数字
	echo "you have type a number:$1"
	;;
	*)
	echo "你输入的是啥啊"
	esac

