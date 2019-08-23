## Shell
	用户与系统内核之间交流平台
## Shell类型
	/bin/sh
	/bin/bash(系统默认bash)
	/bin/tcsh
	/bin/csh
	/etc/shells	放置当前系统可用shell

## 为什么需要shell编程
	1.减少繁琐工作的重复进行，减少错误
	2.提高工作效率
	3.事态的批量化进行




## Bash特点功能
	1.查看命令历史（1000条）
		history  查看历史命令
		history	-c	清空历史命令
		/etc/profile
	2.别名
		alias h5='head -5'
		unalias  h5
	3.管道符重定向
		ps aux | grep '3306'
		echo "passewd" | passwd --stdin username
		ls > list.txt
		ls -l >> list.txt
		mail -s test xx@baidu.com < list.txt


		find / -user yuxiang -type f > all 2> error

	4.命令序列的使用技巧
		在linux中，可以使用控制字符(;,&&,||,&)
		
			&:将程序后台执行
				firefox &   可以用ctrl+z将进程后台执行
				jobs  查看后台任务
				fg n	将后台任务拿到前台
			；：组合多个命令，命令间没有任何逻辑关系，顺序执行
				[root@server ~]# ls /tmp;ls /root;ls /home
			&&：组合多个命令，前一个命令执行成功才能执行后一个
				make && make install
				[root@server ~]# ls -lh initial-setup-ks.cfg && ls .
			||:组合多个命令，前一个执行失败，才会执行后一个
				[root@server ~]# id yuxiang &> /dev/null && echo "hi,yuxiang" || echo "No such user"

	5.花括号{}使用技巧
		通过花括号可以生成命令行或者脚本所需的字串
		括号中可以包含连续的序列或使用逗号分割多个项目
		连续的序列需要包括一个起点和一个终点，俩者之间用“..”分割
		
			[root@server ~]# mkdir /tmp/dir{1,2,3}
			[root@server ~]# mkdir /tmp/{dir4,dir5,dir6}
			[root@server ~]# mkdir /tmp/dir{7..9}
			[root@server ~]# rm -rf /tmp/dir{1..9}
			[root@server ~]# echo user{1,5,9}
			user1 user5 user9
			[root@server ~]# echo {0..10}
			0 1 2 3 4 5 6 7 8 9 10
			[root@server ~]# echo {0..10..2}
			0 2 4 6 8 10
			[root@server ~]# echo {0..10..3}
			0 3 6 9
			[root@server ~]# echo {2..-1}
			2 1 0 -1
			[root@server ~]# 
			


## 变量
	变量是用来存储非固定值的载体，它具有一个值，以及零个或多个属性
	创建变量语法格式：
			name=[value]


	1.变量如果没有指定值（value）,变量将被赋值为空字符串		
	2.变量定义后调用《$变量名》来调用变量
	3.变量的名称为字母，数字，下划线组成
	4.但首字母不能为数字
	5.变量名无硬性的大小写要求，建议使用大写或首字母大写
	6.变量的值可修改，属性可以通过typeset进行修改
		NAME="鱼老板"
		echo $NAME
		typeset -r NAME   #设置变量属性只读 -r

	7.可以利用declare创建一个空变量，暂时不赋值
		[root@server ~]# declare NUMBER		#预先定义变量NUMBER
		[root@server ~]# typeset -i NUMBER		#设置NUNBER属性为整数型
		[root@server ~]# NUMBER=test			#强制赋值给变量
		[root@server ~]# echo $NUMBER			#打印变量结果为0
		0
		[root@server ~]# NUMBER=200				#赋值整数成功
		[root@server ~]# echo $NUMBER
		200
		[root@server ~]# 
	8.通过read命令设置变量
		read从标准输入中读取变量值(类似于python中的input)
		使用-p选项添加相应的提示信息
			[root@server ~]# read SAY
			hello ervery
			[root@server ~]# echo $SAY
			hello ervery
			[root@server ~]# read -p "plese tail me do you have girl friand:" SAY
			plese tail me do you have girl friand:sorry,I do   
			[root@server ~]# echo $SAY
			sorry,I do
			[root@server ~]#
			
	9.set 查看当前系统中设置的所有变量及值
	  unset  #删除变量
		unset 变量名
		[root@server ~]# set | grep SAY
		SAY='sorry,I do'
		[root@server ~]# unset SAY
		[root@server ~]# set | grep SAY
		_=SAY
		[root@server ~]# 



## 变量的作用范围
	使用name=[value]创建变量，默认在当前shell中有效，子进程不会继承这样的变量
	使用export命令将变量放置到环境变量中，此时可全局使用
	export可以直接定义环境变量并赋值
	也可以先定义一个普通的用户变量，然后通export转换为环境变量
	
		[root@server ~]# TEST=new
		[root@server ~]# echo $TEST
		new
		[root@server ~]# bash
		[root@server ~]# echo $TEST
		
		[root@server ~]# exit
		exit
		[root@server ~]# export TEST
		[root@server ~]# export NEW_TEST=hahahha
		[root@server ~]# echo $TEST
		new
		[root@server ~]# echo $NEW_TEST
		hahahha
		[root@server ~]# bash
		[root@server ~]# echo $TEST
		new
		[root@server ~]# echo $NEW_TEST
		hahahha
		[root@server ~]#


## 环境变量
	 Bash为我们预设了很多环境变量，实际操作中我们可以直接调用这些变量(Bash手册)
		SHELL	查看当前系统的默认Bash
		HOSTNAME	查看系统的主机名
		BASHPID		查看当前Bash进程的进程号
		UID		查看当前用户的ID号
		HOME	查看当前用户的家目录
		PWD		查看当前工作目录
		PS1		主命令提示符
		PS2		次命令提示符
		RANDOM	0-32767之间的随机数
		PATH	命令搜索路径


		#path
		添加PATH路径：
			PATH=$PATH:/root	#追加
		注意：绝对不能用下列方法
			PATH=/root		#此操作代表覆盖


## 位置变量（主要体现在脚本中）
	位置变量使得脚本中命令可以调用脚本时不同位置的参数，参数之间一般用空格隔开
	
	$0	代表当前shell程序的文件名称
	$1	代表shell程序的第一个参数
	$2	代表shell程序的第二个参数
		以此类推($1-$9)
	$#	代表shell程序所有参数的个数
	$*和$@	都代表所有参数的内容，区别是$*将所有参数作为一个整体，而$@将所有参数作为个体看待
	$$	代表当前进程的ID号
	%?	代表程序的退出代码(0代表执行成功，非0代表执行失败)

			[root@server ~]# cat weizhi.sh 
			#!/bin/bash
			#This is test script for parme!
			echo "This is the file name:$0"
			echo "This is the first parm:$1"
			echo "This sis the second parm:$2"
			echo "This is the number of all  parm:$#"
			echo "This is the all parm:$*"
			echo "This is the all parm:$@"
			echo "This is PID:$$"
			echo "This is parm over:$?"
			[root@server ~]# 



			[root@server ~]# bash weizhi.sh a_1 b_2 c_3 d_4
			This is the file name:weizhi.sh
			This is the first parm:a_1
			This sis the second parm:b_2
			This is the number of all  parm:4
			This is the all parm:a_1 b_2 c_3 d_4
			This is the all parm:a_1 b_2 c_3 d_4
			This is PID:5224
			This is parm over:0
			[root@server ~]# 




## 变量的展开与替换
	pass


