## 运算(二)
	1++    --1
	shell变量可以自增自减，‘++’，‘--’变量自动加一或者减一，
	位置不同，导致最终的结果不同

	x++		先返回结果，在加1
	++x		先执行加1，在返回结果
	x--		先返回结果，在减一
	--x		先减一，在返回结果

	x=10;echo $((x++));echo $x	
		10
		11
	x=10;echo $((++x));echo $x
		11
		11
	
	在使用自增自减变量赋值时，需注意赋值是否立即生效
	x=10;y=$((x++));echo $y;echo $y
		10
		10
	因为y=$((x++))赋值给y是加一之前的值，虽然赋值结束，$((x++))变为11，但此值和y无关
	x=10;y=$((++x));echo $y;echo $y


	#常用的运算方法：
		let i=i-1
		let i=$i-1
		let i-=1
		i=$((i-1))
		i=$(($i-1))
		i=$[i-1]
		i=$[$i-1]



## 数组也可以进行数学运算
	数组实质是变量，可以支持自增自减操作
	变量内存空间是随机的，而数组内存空间是顺序的
	
	arr_text[0]=10
	let arr_text[0]=${arr_text[0]}-1;echo ${arr_text[0]}
	let arr_text[0]-=1
	

	[root@localhost ~]# echo $((arr_text[0]++))
	8
	[root@localhost ~]# echo $((++arr_text[0]))
	10
	[root@localhost ~]# echo $((arr_text[0]++));echo ${arr_text[0]}
	10
	11
	[root@localhost ~]# echo $((++arr_text[0]))
	12
	[root@localhost ~]# 


## expr(简述加减运算)
	#注意：运算符与数值之间有空格隔开
	expr arg1 + arg2	加法
	expr arg1 - arg2    减法
	expr arg1 \* arg2	乘法
	expr arg1 / arg2	除法
	expr arg1 % arg2	取余


## bc命令高级算数运算
	bc可用于浮点数的计算，bc为linux中的计算器，功能丰富，“强大的让人吐血”
	支持自定义变量，支持自定义函数，支持逻辑运算，支持科学计算
	
	bc

	[root@localhost ~]# bc -q
	pie=3.1415926
	r=3
	pie*r*r					#乘法
	28.2743334

	pie*r^2				#代表幂次方
	28.2743334	
	pie*r^3			
	84.8230002
	quit				#退出

	#bc支持自增自减运算
	root@localhost ~]# bc -q
	
		r=3
		r++
		3
		++r
		5
		--r
		4
		r++
		4


	#人性化操作（批处理）
	var=`echo "option1;option2;…………;expression"|bc`
		options:一般设置精度（scale）,变量赋值	   #只对除法，取余，幂运算有效
		expression：计算表达式
	
		#计算圆的面积
		area=`echo "scale=2;r=3;3.14*r*r"|bc`
		echo $area
	
	#bc接受使用here string和here document接受参数，最常用放置在脚本中；
		[root@localhost ~]# cat yuan.sh 
		#!/bin/bash
		#bc for here string
		#计算圆的面积
		var1=haha
		var2=hahaha
		area=`bc<<EOF
		scale=2
		r=3
		3.1415*r*r
		EOF`
		echo $area
		[root@localhost ~]# bash yuan.sh


	# 补0操作
	例如 0.1+0.1=0.2   不会显示0.2，只是显示.2
	
	echo 0`echo "0.1+0.1"|bc`


	printf "%.2f\n" `echo "0.1+0.1"|bc`