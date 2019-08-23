## Awk简介
	Awk是一种编程语言，诞生于1977年，其名称为三位作者姓的首字母缩写：
	Alfred Aho 、Peter Weinberger 和 Brian Kernighan
	awk主要用于linux/unix下对文本和数据进行扫描处理
	数据可以来自标准输入，文件，管道

	awk有众多的发行版本，awk,nawk,gawk,MKS awk,tawk包括开源产品和商业产品
	目前linux中常用的swk编译器版本mawk，gawk
	rhel系统默认的为gawk
	ubuntu系列产品用mawk

	本节用gawk实现，rhel默认
	GUN开源项目awk解释器的开源代码实现



## Awk工作流程
	首先对文件逐行扫描，从第一行到最后一行，逐行进行匹配特定模式的行,并在这些行上进行用户想要的操作，
	Awk基本结构由模式匹配和处理过程（处理动作）组成
	pattern  ｛action｝

	注意：awk读取文件每一行时，将对改行是否与给定的模式相匹配，如果匹配，则处理执行处理过程，否则不做任何操作，
	如果没有指定处理脚本，则把匹配的行标准输出，默认处理动作为print打印
	如果没有指定模式匹配，则默认匹配所有数据

	Awk有俩个特殊模式，BEGIN/END，被放置在没有读取任何数据之前以及在所有数据读取完成后执行



## Awk的基础语法
	格式：
	gawk  [选项] -f program-file  [--] file ………………

	#选项：
	-F fs， --field-separator fs
	指定fs为输入行的分隔符（默认的分隔符为空格或制表符）
	
	-v var=val，--assign var=val
	在执行处理动作之前，设置一个变量var值为var

	-f program-file，--file program-file
	从脚本文件中读取awk指令，以取代在命令参数中输入脚本

	-W compat，-W traditional，--compat，--traditional
	使用兼容模式运行AWK，GUN拓展选项将被忽略

	-W dump-variables[=file] ，--dump-variables[=file]
	打印全局变量(变量名，类型，值)到文件中，
	如果没有提供文件名，则自动输出至名为dump-variables文件中（演示失败）


	-W copyleft ，-W copyright，--copyleft，--copyright
	输出打印简短的GUN版本信息

- awk程序语法结构：一个awk程序包含一系列的模式{动作指令}或者函数定义
- 模式可以是BEGIN/END/表达式用来限定操作对象的多个表达式使用逗号隔开
- 动作指令需要用{}引起来



## 案例
	1。使用正则表达式匹配空行: /^$/,动作为打印"哈哈哈哈，有空行"
	[root@localhost ~]# awk '/^$/ {print "哈哈哈哈，有空行"}' quote.txt 
	哈哈哈哈，有空行
	哈哈哈哈，有空行
	哈哈哈哈，有空行
	哈哈哈哈，有空行
	[root@localhost ~]# 
	2.匹配包含anconda的行，并打印  /etc/syconfig/network
	[root@#localhost ~]# awk '/anaconda/' /etc/sysconfig/network
	# Created by anaconda
	[root@#localhost ~]# 
	3.利用脚本文件，判断是否有空行
	[root@#localhost ~]# cat awk1.sh 
	/^$/  {print "哈哈哈哈哈哈哈啊哈哈啊"}
	[root@#localhost ~]# 
	[root@#localhost ~]# awk -f awk1.sh quote.txt 
	哈哈哈哈哈哈哈啊哈哈啊
	哈哈哈哈哈哈哈啊哈哈啊
	哈哈哈哈哈哈哈啊哈哈啊
	哈哈哈哈哈哈哈啊哈哈啊
	[root@#localhost ~]# 



## awk操作指令
	1.记录与字段
	Awk一次从文件中读取一条记录，并将记录存储在字段变量$0中，记录被分割为字段并存储在$1,$2,$3………………$NF中（分隔符默认为空格或制表符）
	NF：内建变量，记录的字段个数
	#输出一段话并输出第一个字段，第二个字段，第三个字段
	[root@#localhost ~]# echo I love my gril friend | awk '{print $1,$2,$3}'
	I love my
	[root@#localhost ~]# echo I love my gril friend | awk '{print $1,$2,$3,$5,$4}'
	I love my friend gril
	[root@#localhost ~]# 

	


	#读取输入行数并输出该行
	[root@#localhost ~]# echo hello world | awk '{print $0,$NF}'
	hello world world
	[root@#localhost ~]# echo hahahhahaha | awk -F"a" '{print $NF}'
	
	[root@#localhost ~]# echo hahahhahaha | awk -F"h" '{print $NF}'
	a
	[root@#localhost ~]# 


	2.字段与分隔符
	默认awk读取数据以空格或制表符作为分隔符
	但可以通过-F来改变分隔符
	
	[root@#localhost ~]# awk -F: '{print $1}' /etc/passwd
	[root@#localhost ~]# awk 'BEGIN {FS=":"} {print $1}' /etc/passwd

	#指定多个分割符
	[root@#localhost ~]# echo 'hello the:world,!' | awk 'BEGIN {FS="[:,]"} {print $1,$2,$3,$4}'
	hello the world ! 
	[root@#localhost ~]#

	
	3.内置变量
	变量名称				描述
	ARGC			命令行参数个数
	FILENAME		当前输入文档的名称
	FNR				当前输入文档的记录编号，多个输入文档时有用
	NR				输入流当前记录编号
	NF				当前记录的字段个数
	FS				字段分隔符
	OFS				输出字段分隔符，默认是空格
	ORS				输出记录分隔符，默认换行符 \n
	RS				输入记录分隔符，默认换行符



	#示例文件
	[root@#localhost ~]# cat test1.txt 
	This is a test file
	Welcome to Jacob's Class
	[root@#localhost ~]# cat test2.txt 
	Hello the world
	Wow! I'm overwhelmed.
	Ask for more
	[root@#localhost ~]#


	#输出当前文档的当前行编号，第一个文件俩行，第二个文件三行
	[root@#localhost ~]# awk '{print FNR}' test1.txt test2.txt 
	

	#Awk将俩个文档作为一个整体的输入流，通过NR输入当前编号
	[root@#localhost ~]# awk '{print NR}' test1.txt test2.txt


	[root@#localhost ~]# awk '{print $1,$2,$3,$4}' test1.txt 
	This is a test
	Welcome to Jacob's Class
	[root@#localhost ~]# 
		

	#通过OFS将输出分割符设置为'-',print在输出时第1,2,3个字段中间的分割符为‘-’
	
	[root@#localhost ~]# awk 'BEGIN {OFS="-"} {print $1,$2,$3,$4}' test1.txt 
	This-is-a-test
	Welcome-to-Jacob's-Class
	[root@#localhost ~]#

	
	#示例文件
	[root@#localhost ~]# cat test3.txt 
	mail from:tomcat@gmail.com
	subjectLhello
	data:2018-11-12 17:00
	content:Hello,The world
	
	mail from: jerry@gamil.com
	subject:congregation
	data:2018-11-12 08:31
	content:Congregation to you.
	
	mail from: jacob@gmail.com
	subject:Test
	data:2018-11-12 10:20
	content:This is a test mail
	[root@#localhost ~]# 

	#读取输入数据，以空白行为记录分割符，即第一个空白行前的内容为一个记录

	 [root@#localhost ~]# awk 'BEGIN {FS="\n";RS=""} {print $2}' test3.txt 
	subjectLhello
	subject:congregation
	subject:Test
	[root@#localhost ~]# 

	





	4.表达式与操作
		表达式由变量，常量，函数，正则表达式，操作符组成
		awk中变量有字符和数字变量，如果在awk中定义变量没有初始化，则初始化值为空字符或0
		字符操作一定加引号
	
		#定义变量
		a='hello'
		b=12
		

		#操作符
		+
		-
		*
		/	除
		%	取余
		^	幂运算
		++
		--
		+=
		-=
		*=
		/=
		'>'
		<
		>=
		<=
		==  等于
		!=   不等于
		~	匹配
		!~	不匹配
		&&	与
		||	或
	

		#案例
		
		[root@#localhost ~]# echo test | awk 'x=2 {print x+3}'
		
		[root@#localhost ~]# echo hello | awk 'x=1,y=3 {print x*2,y*3}'
		2 9
		[root@#localhost ~]# 


		#统计所有空白行
		[root@#localhost ~]# awk '/^$/ {print x+=1}' test3.txt 
		1
		2
		[root@#localhost ~]# awk '/^$/ {x+=1} END {print x}' test3.txt 
		2
		[root@#localhost ~]# 

		#打印root用户的额ID号
		[root@#localhost ~]# awk -F: '$1~/root/ {print $3}' /etc/passwd
		0
		
		#打印用户uid号大于500的用户
		
		[root@#localhost ~]# awk -F: '$3>500 {print $1}' /etc/passwd
		polkitd
		unbound
		colord
		saslauth
		libstoragemgmt
		nfsnobody
		chrony
		gnome-initial-setup
		hello
		[root@#localhost ~]# 








### 见鬼啦
	[root@#localhost ~]# awk 'BEGIN {OFS="-"}{print $1,$2,$3}' test1.txt 
	This-is-a
	Welcome-to-Jacob's
	[root@#localhost ~]# awk 'BEGIN {OFS="-"} {print $1,$2,$3}' test1.txt 
	This-is-a
	Welcome-to-Jacob's
	[root@#localhost ~]# awk 'GEGIN {OFS="-"} {print $1,$2,$3,$4}' test1.txt
	This is a test
	Welcome to Jacob's Class
	[root@#localhost ~]# awk 'BEGIN {OFS="-"} {print $1,$2,$3}' test1.txt 
	This-is-a
	Welcome-to-Jacob's
	[root@#localhost ~]# awk 'BEGIN {OFS="-"} {print $1,$2,$3,$4}' test1.txt 
	This-is-a-test
	Welcome-to-Jacob's-Class
	[root@#localhost ~]# 



	