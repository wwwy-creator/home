## 变量的展开与替换
	#一下四组用于需要确定变量是否正确设置环境
		${varname:-work}	#当varname存在且不为空，则返回varname值，否则返回word
		${varname:=word}	#当varname存在且不为空,返回varname值，否则返回word
		${varname:?message}	#当varname存在且不为空，返回varname值，否则显示varname:message
		${varname:+word}	#当varname存在且不为空，返回word，否则返回null
			[root@localhost ~]# NAME=BJTLXY
			[root@localhost ~]# echo $NAME
			BJTLXY
			[root@localhost ~]# echo ${NAME:-no user};echo ${NAME}
			BJTLXY
			BJTLXY
			[root@localhost ~]# echo ${NAME:=dana};echo ${NAME}
			BJTLXY
			BJTLXY
			[root@localhost ~]# echo ${NAMEs:=dana};echo ${NAME}
			dana
			BJTLXY
			[root@localhost ~]# echo ${NAME:?shuo sha lie};echo $NAME
			BJTLXY
			BJTLXY
			[root@localhost ~]# echo ${NAMEs:?shuo sha lie};echo $NAME
			dana
			BJTLXY
			[root@localhost ~]# echo ${NAMES:?shuo sha lie};echo $NAME
			-bash: NAMES: shuo sha lie
			[root@localhost ~]# echo ${NAMEses:+huanglaoban};echo $NAME
			
			BJTLXY
			[root@localhost ~]# echo ${NAME:+huanglaoban};echo $NAME
			huanglaoban
			BJTLXY
			[root@localhost ~]# 
	#下面六组主要用于需要对变量的值做修改后输出的场景
		${varname#key}		#从头开始删除关键字(key)，执行最短匹配
		${varname##key}		#从头开始删除关键字，执行最长匹配
		${varname%key}		#从尾部开始删除关键字，执行最短匹配
		${varname%%key}		#从尾部开始删除关键字，执行最长匹配
		${varname/old/new}	#将old替换为new，替换第一个出现的old
		${varname//old//new}	#将old替换为new，替换所有

			[root@localhost ~]# USR=$(head -1 /etc/passwd)
			[root@localhost ~]# echo $USR
			root:x:0:0:root:/root:/bin/bash
			[root@localhost ~]# echo ${USR#*:}
			x:0:0:root:/root:/bin/bash
			[root@localhost ~]# echo $USR
			root:x:0:0:root:/root:/bin/bash
			[root@localhost ~]# echo ${USR##*:}
			/bin/bash
			[root@localhost ~]# echo ${USR%:*}
			root:x:0:0:root:/root
			[root@localhost ~]# echo ${USR%%:*}
			root
			[root@localhost ~]# echo ${USR/root/admin}
			admin:x:0:0:root:/root:/bin/bash
			[root@localhost ~]# echo ${USR//root//admin}
			/admin:x:0:0:/admin://admin:/bin/bash
			[root@localhost ~]# 




## 数组
	一组具有相同数据类型的集合
	数据类型：
		数值类型：
		字符串类型：
	bash提供一维数组的变量功能，数组中所有便利那个都会被编录成索引，数组的索引从0开始
	
	创建数组：
	1.name[subscript]=value
	2.name=(value1………………valuen)
	3.declare -a <name>	定义一个空数组



	获取数组的值
	可以使用echo ${name[subscript]} 通过索引得到数组的值
	如果subscript是@后者*，则将调用所有的数组成员
	如果使用${#name[subscript]}可以返回${name[subscript]}长度
	如果是*或@,则返回数组中元素个数

		[root@localhost ~]# A[1]=11
		[root@localhost ~]# A[2]=22
		[root@localhost ~]# A[3]=33
		[root@localhost ~]# echo ${A[0]}
		
		[root@localhost ~]# echo ${A[1]}
		11
		[root@localhost ~]# echo ${A[-1]}
		33
		[root@localhost ~]# A[-1]=99
		-bash: A[-1]: bad array subscript
		[root@localhost ~]# A[6]=66
		[root@localhost ~]# echo ${A[*]}
		11 22 33 66
		[root@localhost ~]# echo ${A[@]}
		11 22 33 66
		[root@localhost ~]# echo ${#name[*]}
		0
		[root@localhost ~]# echo ${#name[@]}
		0
		[root@localhost ~]# echo ${#A[@]}
		4
		[root@localhost ~]# echo ${#A[1]}
		2
		[root@localhost ~]# echo ${A[0]},${A[1]},${A[2]},${A[3]}
		,11,22,33
		[root@localhost ~]# A[0]=00
		[root@localhost ~]# echo ${A[0]},${A[1]},${A[2]},${A[3]}
		00,11,22,33
		[root@localhost ~]# 



		
		[root@localhost ~]# B=(aa bb cc)
		[root@localhost ~]# echo ${B[0]},${B[1]},${B[2]}
		aa,bb,cc
		[root@localhost ~]# echo ${B[0]}:${B[1]}:${B[2]}
		aa:bb:cc
		[root@localhost ~]# echo 'length if B_0 is ${#B[0]}'    #请注意此处的错误
		length if B_0 is ${#B[0]}
		[root@localhost ~]# echo 'length of B_0 is' ${#B[0]}
		length of B_0 is 2
		[root@localhost ~]# echo 'length of B_1 is' ${#B[1]}
		length of B_1 is 2
		[root@localhost ~]# echo ${#B[*]}
		3
		[root@localhost ~]# 



		数值型数组：（一对括号表示，元素之间空格隔开）
			arr_num=(1 2 3 4 5 6）
		字符型数组：
			arr_string=（'aa' 'bb' 'cc' 'dd' ）
		
		获取数组的长度：
			arr_length=${#arr_num[*]}
			arr_length=${#arr_string[@]}
		列出索引下标：
			echo ${!arr_num[@]}
		读取某个下标的值：
			arr_index_2=${arr_num[2]}
		对某个下标进行赋值
			下标存在：相当与修改原有的值
				arr_num[2]=100
			下标不存在，按照升序走
				arr_num[23]=100
		删除操作：
			清除某个元素
				unset arr_num[1]
			清除整个数组：
				unset arr_num
		数组的切片：
			格式：${数组名[@/*]:开始下标：结束下标}
			echo ${arr_string[*]:2:3}
		数组的遍历：
			for v in ${arr_string[@]};do
				echo $v;
			done





## 算数运算
	在Bash中可以使用let，(()),$(())或者$[]进行基本的整数运算，还可以使用bc进行高级运算，包括小数运算，还可以使用expr命令进行整数运算，还能判断参数是否为整数

	注意：let和(())几乎完全等价，除了做数学运算，还支持数据表达式判断，例如数值a是否等于3
		let a==3或((a==3)),但一般不用，我们用test命令来做，test '$a' -eq 3


	num=10
	let num=num+10	#等价于 let num+=10
	let num=num-10	#等价于 let num-+5
	echo $num

	let可以使用(())进行替换，如果最后一个算数表达式的结果为0，则返回状态码1，否则返回0
	$(())或者$[]

	num=10
	echo $((num+=6))
	echo $[num-=16]
	
	此操作也可以为变量赋值
		num=$((num-=10));echo $num
		num=$[num-=6];echo $num
	
	在算数计算过程中，等号右边的变量可以带着$符号，但等号左边的变量不允许带$符号
	let num=#num-1		== 		let num=num-1
	num=$(($num-1))		==		num=$((num-1))

	$((num=$num-1))		==	$((num=num-1))		!=		$(($num=num-1))



	#
	$((x+y))	加法运算		echo $((1+2))
	$((x-y))	减法运算		echo $((1-2))
	$((x*y))	乘法运算		echo $((1*2))
	$((x/y))	触发运算(取商)	echo $((8/6))
	$((x%y))	取余运算		echo $((5%3))
	$((x++))	自加运算		echo $((9++))
	$((x--))	自减运算		echo $((9--))
	$((x**y))	幂运算		echo $((3**3))
