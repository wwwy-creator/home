# shell函数练习


## 检查主机存活状态

	- 有一个主机列表

	- 将错误ip放到数组里面判断是否ping失败三次

	/bin/bash
	# test host living status
	#host list
	IP_LIST="192.168.0.1 192.168.0.2 192.168.13.141 192.168.1.7 192.168.1.8 192.168.1.6 192.168.1.5"
	for IP in $IP_LIST;do
	    NUM=1
	    while [ $NUM -le 3 ];do
	        if ping -c 1 $IP >/dev/null;then
	            echo "$IP ping is successful."
	            break
	        else
	            echo "$IP ping is faiure $NUM"
	            FALL_COUNT[$NUM]=$IP
	            let NUM++
	        fi
	    done
	    #the  fail ip  to arr and ping three time
	    if [ ${#FALL_COUNT[*]} -eq 3 ];then
	        echo "${FALL_COUNT[1]} Ping is failure!"
	        unset FALL_COUNT[*]
	    fi
	done


	- 将错误次数放到FALL_COUNT便利那个里面判断是否ping三次失败

	#!/bin/bash
	# test host living status
	#host list
	IP_LIST="192.168.0.1 192.168.0.2 192.168.13.141 192.168.1.7 192.168.1.8 192.168.1.6 192.168.1.5"
	for IP  in $IP_LIST;do
	    FALL_COUNT=0
	    for ((i=1;i<=3;i++));do
	        if ping -c 1 $IP > /dev/null;then
	            echo "$IP ping is successfull."
	            break
	        else
	            echo "$IP ping is failure $i"
	            let FALL_COUNT++
	        fi
	    done
	    if [ $FALL_COUNT -eq 3 ];then
	        echo "$IP Ping is failure~~"
	    fi
	done



	- 利用for循环将ping通的地址跳出循环继续，如果跳不出打印ping失败

	#!/bin/bash
	# test host living status
	#host list
	IP_LIST="192.168.0.1 192.168.0.2 192.168.13.141 192.168.1.7 192.168.1.8 192.168.1.6 192.168.1.5"
	ping_success_status() {
	    if ping -c 1 $IP > /dev/null;then
	        echo "$IP Ping is susccessful"
	        continue
	    fi
	}
	
	for IP in $IP_LIST;do
	    ping_success_status
	    ping_success_status
	    ping_success_status
	    echo "$IP ping is failure~~~~"
	done






## 判断输入的是否是IP


	- 第一种

    #!/bin/bash
	#check input is ip address?
	function check_ip {
	    IP=$1
	    VALID_CHECK=$(echo $IP|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "Yes"}')
	    if echo $IP | grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" >/dev/null;then
	        if [ $VALID_CHECK == "Yes" ];then
	            echo "$IP is IPv4 address!!"
	        else
	            echo "$IP not Ipv4 address!!!"
	        fi
	    else
	        echo "$IP Format Error~~~~"
	    fi
	}
	check_ip 192.168.1.1
	check_ip 2662.2432.232.322
	check_ip ccsacascascca
	check_ip a.a.a.a
	check_ip 0.2.3.3
	check_ip 0..32.
	check_ip 10.10.3.6




	- 第二种
	/bin/bash
	#check input is ip address?
	function check_ip {
	    IP=$1
	    VALID_CHECK=$(echo $IP|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "Yes"}')
	    if echo $IP | grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" >/dev/null;then
	        if [ $VALID_CHECK == "Yes" ];then
	            echo "$IP is IPv4 address!!"
	            return 0
	        else
	            echo "$IP not Ipv4 address!!!"
	            return 1
	        fi
	    else
	        echo "$IP Format Error~~~~"
	        return 1
	    fi
	}
	while true;do
	    read -p "plses input one ip address:" IP
	    check_ip $IP
	    [ $? -eq 0 ] && break || continue
	done





## RHCE脚本考题

	- 基础题
		- 在某台设备上创建一个名为/root/foo.sh的脚本
		- 当运行/root/foo.sh redhat是输出fedora
		- 当运行/root/foo.sh fedora是输出redhat
		- 当没有任何参数或者参数不是以上俩个则输出/root/foo.sh redhat|fedora


	!/bin/bash
	case $1 in
	    fedora)
	        echo "redhat"
	        ;;
	    redhat)
	        echo "fedora"
	        ;;
	    *)
	        echo "/root/foo.sh redhat|fedora"
	esac



	- 进阶题目
		- 创建一个添加用户的脚本
		- https://wenku.baidu.com/view/b1c071b2690203d8ce2f0066f5335a8102d26632.html


		#!/bin/bahs
		if [ $# -ne 1];then
		echo "wenjia meiyou "
		exit 1
		elif [ if $1 ];then
		for i in `cat $1`
		do
		useradd -s /bin/false $i
		done
		else
		echo "input file not found" >&2
		exit 1
		fi
