# 控制语句应用
	shell支持的控制语句有break,continue,exit,shift



	shift的作用是将位置参数参数左移一位，没执行一次shift，$2将变为$1,依次类推
	
	[root@server0 programe]# chmod u+x shift_.sh 
	[root@server0 programe]# ./shift_.sh  one two three four five six seven eight 
	one
	two
	three
	four
	five
	six
	seven
	eight
	[root@server0 programe]# cat shift_.sh 
	#!/bin/bash
	for i in $@
	do
	echo $1
	shift
	done
	[root@server0 programe]# 





	continue用来在for,while，until循环中使用当前循环中断执行，进入下一次循环
	break，终止整个for,while,until循环
	exit用来结束脚本的运行

	[root@server0 programe]# cat con_p.sh 
	#!/bin/bash
	for num in {1..100}
	    do
	    case $num in
		1)
		    continue
		    ;;
		5)
		    break
		    ;;
	    esac
		echo ${num}
	done
	sleep 5
	exit
	echo "……………………………………………………"
	[root@server0 programe]# 
