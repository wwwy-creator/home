## shell函数应用
	在编写脚本时，部分语句会被重复多次使用，把这些可能重复的代码写成函数
    比如某些功能的代码，封装为函数
	将程序进行模块化
	函数需要先定义后调用
	


## 函数的语法格式
	语法格式一：
	name() {
	命令序列
	}

	语法格式二
	function name {
	命令序列
	}



## 函数案例
	#根据用户对菜单的选择调用不同的函数功能
	[root@server0 programe]# cat update_menu.sh 
	#!/bin/bash
	
	#打印提示符
	HINT() {
	read -p "Press Enter to continue:"
	}
	
	#查看CPU信息
	CPU_INFO() {
	echo
	echo -e "\033[4;31mPrint the CPU info:\033[0m"
	cat /proc/cpuinfo | awk 'BEGIN {FS=":"} /model name/{print "CPU Model:"$2}'
	cat /proc/cpuinfo | awk 'BEGIN {FS=":"} /cpu MHz/{print "CPU Speed:"$2"MHz"}'
	grep -Eq "svm|vmx" /proc/cpuinfo  && echo "Virtualiztion:Support" || echo "Virtualiztion:NO Support"
	echo
	}
	
	
	#查看系统负载
	LOAD_INFO() {
	echo
	echo -e "\033[4;31mPrint the System load info:\033[0m"
	uptime | awk 'BEGIN{FS=":"}{print $5}' | awk 'BEGIN{FS=","}{print "Last 1 minutes system load:"$1"\n""Last 5 minutes system load:"$2"\n""Last 15 minutes system load"$3}'
	echo
	}
	
	
	# 查看内存与交换分区信息
	MEM_INFO() {
	echo
	echo -e "\033[4;31mPrint the System load info:\033[0m"
	free | grep buffers/cache | awk '{print "Mem free:"$4" Bytes"}'
	free | grep Swap | awk '{print "Swap free:"$4" Bytes"}'
	echo
	}
	
	
	#磁盘挂载信息
	DISK_INFO() {
	echo
	echo -e "\033[4;31mPrint the disk sapce info:\033[0m"
	df -hT
	echo
	}
	
	
	
	while true     #无限循环
	do
	clear
	echo "…………………………………………………………………………………………"
	echo "1.Display CPU info:"
	echo "2.Display system load:"
	echo "3.Display Mem and swap info:"
	echo "4.Display filesytem mount info:"
	echo "5.Exit Program"
	echo "…………………………………………………………………………………………"
	read -p "plese select your iterm(1-5):" U_SELECT
	case $U_SELECT in
	    1)
	        CPU_INFO
		HINT
	        ;;
	    2)
		LOAD_INFO
		HINT
	        ;;
	    3)
		MEM_INFO
		HINT
	        ;;
	    4)
		DISK_INFO
		HINT
	        ;;
	    5)
	        break
	        ;;
	    *)
	        read -p "plese select 1-5,Press Enter to continue:"
	esac
	done
	[root@server0 programe]# 






## 检查用户密码，如果三次输入密码错误，则退出脚本
	#!/bin/bash
	#用户的初始密码
	PASSWD="passwd"
	#计数器
	SUM=0
	
	while true
	do
	read -p "Plses input your password:"  pass   #读取用户输入的密码信息
	
	#计数器加一
	SUM=$((SUM+1))
	
	if [ $pass == $PASSWD ];then
	    echo "Your passwd Right,进去吧~"
	    break
	elif [ $SUM -lt 3 ];then
	    continue
	else
	    echo "your passwd error,plese check your password~"
	    break
	fi
	done



## 定义一个颜色输出字符串函数
	#!/bin/bash
	function echo_color {
	if [ $1 == "green" ];then
	    echo -e "\033[32;40m$2\033[0m"
	elif [ $1 == "red" ];then
	    echo -e "\033[31;40m$2\033[0m"
	fi
	}
	echo_color red "你没的"




