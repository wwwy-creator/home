##测试（test）



## 退出与测试
	在linux中，每个命令或者脚本完成后都会有一个退出状态：
	在shell中有一个内部命令test命令用于判断语句进行测试一种或者几种状态条件是否成立
	#退出状态，测试和判断密切相关


## 退出状态：
	当命令执行成功后，系统会返回一个退出状态，这个状态由数值表示，判断命令是否正确执行，若退出状态为0，表示命令执行成功，若为其他数值，则表示运行失败


	查看状态码用 $?

	状态码		含义
	0			代表运行成功，程序执行ok
	1-125		代表执行失败，脚本，命令，系统命令或传递参数失败
	126			找到了命令但无法执行
	127			没找到命令
	>128        命令被系统强制结束

	ls;echo $?


## 测试结构
	测试命令用于测试表达式的条件的真假，如果条件为真，则返回0，
	如果条件为假，则返回一个非0数值
	
	#测试结构语法
	第一种：
		test expression
		
		expression为表达式，该表达式可以是数字，字符串，文本，文件属性的比较

	第二种：
		[ expression ]
		
		expression为表达式
		[ 代表测试启动
		表达式与[]俩边必须有空格，
		这种方法经常与if，Case，while等语句连用






## 整数比较运算符
	主要用于俩个值的比较，比较简答
	
	#测试结构
		test 'num'  整数比较运算符  ‘num’
	或：
		[ ‘num’ 整数比较运算符 ‘num’ ]


	#常用运算符
	num1 -eq num2		如果num1等于nunm2，测试结果为0
	num1 -ge num2		如果num1大于等于num2，测试结果为0
	num1 -gt num2		如果num1大于num2，测试结果为0
	num1 -le num2		如果num1小于等于num2，测试结果为0
	num1 -lt num2		如果num1小于num2，测试结果为0
	num1 -ne num2		如果num1不等于num2，测试结果为0

	
	#一个整数与一个整数常量的比较
	[root@localhost ~]# num=15
	[root@localhost ~]# [ "$num" -eq 15 ];echo $?
	0
	[root@localhost ~]# [ "$num" -gt 10 ];echo $?
	0
	[root@localhost ~]# [ "$num" -gt 20 ];echo $?
	1
	[root@localhost ~]# [ "$num" -lt 15 ];echo $?
	1
	[root@localhost ~]# 

	#俩个变量作比较
	[root@localhost ~]# first_num=99
	[root@localhost ~]# second_num=100
	[root@localhost ~]# [ "$first_num" -gt "$second_num" ];echo $?
	1
	[root@localhost ~]# [ "$first_num" -lt "$second_num" ];echo $?
	0
	[root@localhost ~]# 

	
	#注意：整数比较运算符不适用与浮点型数值比较，这一点与C语言区别
	[root@localhost ~]# [ 1.5 -lt 2.2 ];echo $?
	-bash: [: 1.5: integer expression expected
	2


## 字符串运算
## 文件操作符
## 逻辑运算
## 引号
## 脚本初始
## 判断语句