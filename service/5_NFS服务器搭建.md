# DHCP自动部署脚本

	#!/bin/bash
	#Auto deploy DHCP server   for 192.168.0.0/24 network
	
	# bian liang   net   mask   range
	
	
	NET=192.168.0.0
	MASK=255.255.255.0
	RANGE="192.168.0.70 192.168.0.80"
	DNS=8.8.8.8
	DOMAIN_NAME="example.com"
	ROUTER=192.168.0.254
	
	
	#test yum
	tets_yum() {
	yum list dhcp > /dev/null 2& >1
	if [ $? -ne 0 ];then
		echo
		echo "There was an error to yum....."
		echo "plese verify your yum settings and try again..."
		echo
		exit
	fi
	}	
	
	#cp config 
	test_conf() {
	if [ -f /etc/dhcp/dhcpd.conf ];then
		mv /etc/dhcp/dhcpd.conf  /etc/dhcp/dhcpd.conf.bak
	fi
	}
	
	
	# create new dhcp config
	create_conf() {
	cat >  /etc/dhcp/dhcpd.conf << EOF
	#dhcpd.conf
	default-lease-time 600;
	max-lease-time 7200;
	subnet 192.168.0.0  netmask 255.255.255.0 {
	  range $RANGE;
	  option domain-name-servers $DNS;
	  option domain-name "$DOMAIN_NAME";
	  option routers $ROUTER;
	  option broadcast-address 192.168.0.255;
	  default-lease-time 600;
	  max-lease-time 7200;
	}
	EOF
	}

	
	rpm -q dhcp > /dev/null 2& >1
	if [ $? -ne 0 ];then
	    test_yum
	    yum install dhcp -y > /dev/null 2& >1
	fi
	test_conf
	create_conf
	systemctl restart dhcpd
	systemctl enable dhcpd
	sleep 10




## NFS网络文件服务
	- Network File System   网络文件系统
	- 用于unix/类unix系统之间进行文件共享
	- sun
	- NFSv2  NFSv3  NFSv4
	- NFS 端口好  tcp 2049


## 工作原理
	- C/S
	- RPC  远程过程调用
		- 为远程通信双方提供与喜爱基本信息
	- rhel7系统又rpcbind提供RPC协议支持
	- V4不需要rpcbind提供服务，但依然依赖rpc.mountd
	- 系统默认提供V4版本的共享

	- 所需软件包
		- nfs-utils
		- rpcbind


## 客户端于服务端NFS通讯过程
	- 首先服务器端启动RPC服务，开启111端口
	- 启动nfs服务，并向RPC注册端口信息
	- 客户端启动RPC（portmap），向服务端rpc请求NFS服务端口
	- 服务端反馈NFS端口信息给客户端
	- 客户端拿着NFS端口信息访问NFS文件共享




## NFS实现过程
	- 所需软件
		- nfs-utils
		- rpc-bind
	- 安装所需软件
		- yum install nfs-untils rpcbind  -y
	- 检测
		- rpm -qa | grep nfs


	- 服务配置文件
		- /etc/exports
		- <共享目录>   [客户端1 选项] [客户端2 选项]
		- /nfsshare   *(rw,all_squash,sysnc,anonuid=1001)


	- 客户端常用指定方式
		- * 所有主机
		- 指定ip地址主机	192.168.0.1
		- 指定网段	192.168.0.0/24     192.168.0.0/255.255.255.0
		- 指定域名主机	www.example.com
		- 指定域中所有主机	*.example.com

	- NFS常用选项
		- ro	只读
		- rw	读写权限
		- all_squash  访问用户映射为匿名用户  NFS nobody
		- no_all_squash   与上面取反
		- root_squash	屏蔽远程root权限
		- no_root_squash	不屏蔽
		- anonuid	将访问用户映射为匿名用户，并制定为本地用户	
		- anungid	将访问用户映射为匿名用户，并制定为组
		- sync	同步写入，效率低，但是保证数据的一致性
		- async	将数据写入内存中则可，等带刷盘



## 服务端操作
	  yum install nfs-untils rpcbind -y
  129  systemctl restart rpcbind.service 
  130  systemctl restart nfs-server
  131  systemctl enable nfs-server
  132  systemctl enable rpcbind.service 
  133  firewall-cmd --permanent --add-service=nfs 
  134  firewall-cmd --permanent --add-service=mountd 
  135  firewall-cmd --reload 
  136  mkdir /nfsshare
  137  echo "hello world " > /nfsshare/test.txt
  138  vim /etc/exports
  139  systemctl restart rpcbind.service 
  140  systemctl restart nfs-server.service

	[root@localhost ~]# cat /etc/exports
	/nfsshare	192.168.0.0/24(rw,sync)
	[root@localhost ~]# 




## 客户端
	- 客户端扫描共享文件
	- showmount
		- a		列出nfs服务共享的完整目录信息
		- d		仅列出客户端远程安装目录
		- e		显示导出目录的列表
	

	   	20  showmount -e 192.168.0.20
  	 	21  mkdir /mnt/share
   		22  df -hT
   		23  mount -t nfs 192.168.0.20:/mnt/share/ /mnt/share/




		- 永久挂载
			- 192.168.0.20:/mnt/share	/mnt/share	nfs	defaults	0 0

