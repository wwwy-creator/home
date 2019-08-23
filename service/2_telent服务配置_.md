# linux下配置Telent服务



## telent简介
	- 隶属于TCP/IP协议族
	- 提供远程登陆服务
	- 既不安全
	- 确定远程服务器的状态
	- 远程管理
		- LAN  WAN 拨号
		- NETBEUI   netbios  tcp

## 远程管理应用
	- 远程办公
		- 节省资本，提高办公效率
	- 远程技术支持
		- 400
	- 远程教学
		- 直播
	- 远程维护与管理


## telent工作原理
	telent协议可以工作在任何操作系统任何终端之间
	RFC854	telent协议说明书
		- 定义了一种通用字符终端，NVT（Network virtual terminal）
	
	NVT是一种虚拟设备，连接双方操作，都必须把他们的物理终端和NVT进行互相转换
	操作系统必须能够把NVT格式转换为终端所能够支持的格式

## 实现流程
	客户端：
		建立与服务端的TCP连接
		从键盘接受输入的字符
		把输入的字符串变成标准格式并发送给远程服务器
		从远程服务器接受输出的信息
		把信息显示在屏幕上
	服务端：
		telent服务处于侦听状态  23   一旦连接 马上活跃
		通知客户端，远程计算机准备ok
		等待命令到达：
		对输入的命令进行一系列反应
		把执行结果返回给客户端计算机
		继续等候输入命令


## telenet命令集
	EOF	文件结束符






## 搭建telent服务器

	- 软件安装
		- 由于telnet服务由xinetd守护
		- telent-server
		- xinetd（extend internet daemon）（超级internet服务器）
		- 默认情况下禁止root用户登陆

	-
		 172  yum install telnet
 		 173  yum install telnet-server.x86_64 -y
  		 174  yum install xinetd.x86_64 -y
	- 重启服务/防火墙设置
		176  systemctl restart xinetd.service 
 		177  systemctl enable xinetd.service 
  		179  systemctl restart telnet.socket
 		180  systemctl enable telnet.socket
 		181  firewall-cmd --permanent --add-service=telnet 
 		182  firewall-cmd --reload









## telnet配置文件   /etc/xinetd.d/telent
	# default: on
	# description: The telnet server serves telnet sessions; it uses \
	#       unencrypted username/password pairs for authentication.
	service telnet
	{
	        flags           = REUSE      #为服务设置特定的标志
	        socket_type     = stream	#套接字类型 stream 流  tcp
	        wait            = no		#服务进行是否是单线程  no 多线程
	        user            = root			#root用户
	        server          = /usr/sbin/in.telnetd	
	        log_on_failure  += USERID		#错误日志 在原来基础之上 +USERID
	        disable         = yes
	}


	- /etc/xinetd.conf





## 客户端连接
	yum install telent  -y
	telnet address port 23