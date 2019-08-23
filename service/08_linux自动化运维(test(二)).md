## test（二）

## 字符串运算符
	字符串运算符可以用来测试字符串是否为空，俩个字符串是否想灯光或者不相等，
	主要用来测试用户用户输入是否为空或者判断计较字符串变量；

	#字符串运算符总共有5种
	
	#注意，字符串运算符只能使用test，不能使用[]这种格式
	#俩个字符串进行比较时，变量也用双引号引起来，变量为空也得用双引号

	string		测试字符串是否不为空
	-n	string		测试字符串是否不为空（为空等于长度为0）
	-z	string		测试字符串string是否为空
	string1=string2	测试字符串是否相等
	string！=string2	测试字符串是否不相等


		[root@localhost Desktop]# str1="";test "$str1";echo $?
		1
		[root@localhost Desktop]# str1="7";test "$str1";echo $?
		0
		[root@localhost Desktop]# test -n "$str1";echo $?
		0
		[root@localhost Desktop]# test -z "$str1";echo $?
		1
		[root@localhost Desktop]# 

		[root@localhost Desktop]# str1="vi"
		[root@localhost Desktop]# str2="vim"
		[root@localhost Desktop]# [ "$str1" = "$str2" ];echo $?
		1
		[root@localhost Desktop]# [ "$str1" != "$str2" ];echo $?
		0
		[root@localhost Desktop]# 


		[root@localhost Desktop]# str="hello "
		[root@localhost Desktop]# [ "$str" = "hello" ];echo $?
		1
		[root@localhost Desktop]# str="hello"
		[root@localhost Desktop]# [ "$str" = "HELLO" ];echo $?
		1
		[root@localhost Desktop]# 


		num="007"		#给变量赋值，可以当作整数，也可以当作字符串
		[ "$num" -eq "7" ];echo $?		#测试变量num是否等于整数7
		[ "$num" = "7" ];echo $?	#测试变量num的值是否等于字符串7		  


		


## 文件操作符
	可以完成测试文件的各种操作
	格式：
		test file_operator file
	或：
		[ file_operator file ]

	#常用的文件操作符

	-d	file		#测试file是否是目录
	-e	file		#测试file是否存在
	-f	file		#测试file是否是普通文件
	-r	file		#测试file是否可读
	-s	file		#测试file是否不为空
	-w	file		#测试file是否可写
	-x	file		#测试file是否是可执行文件
	-h	file		#测试file是否是链接文件



	[root@localhost ~]# [ -e xasxa ] && echo  "Y"  || echo "N"  && echo $? 
	N
	0
	[root@localhost ~]# 
	[root@localhost ~]# [ -f /etc/passwd ] && echo  "Y"  || echo "N"
	Y
	[root@localhost ~]# [ -f /etc/passwds ] && echo  "Y"  || echo "N"
	N
	[root@localhost ~]# 
	[root@localhost ~]# test -d /etc/ && echo "Y" ||  echo "N"
	Y
	[root@localhost ~]# 


## 逻辑运算符
	逻辑运算符用于测试多个条件是否为真为假，或使用逻辑非运算测试单个表达式
	
	逻辑非，逻辑与，逻辑或
	
	！	expression	  #如果expression，整个测试结果为真
	expression1 -a  expression2     #同时为真则为真
	expression  -o	expression2		#有真则真

	

	[root@localhost ~]# [ -e initial-setup-ks.cfg ];echo $?
	0
	[root@localhost ~]# [ !  -e initial-setup-ks.cfg ];echo $?
	1
	[root@localhost ~]# [ -e initial-setup-ks.cfg -a -x anaconda-ks.cfg ];echo $?
	1
	[root@localhost ~]# 


	
	[root@localhost ~]# num=15
	[root@localhost ~]# [ "$num" -lt 20 -o "$num" -gt 30 ];echo $?
	0
	[root@localhost ~]# 
