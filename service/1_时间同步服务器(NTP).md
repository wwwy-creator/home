# 时间同步服务器
	> Network time Protocol(NTP)
	> NTP之关注实践操作



## 时间与时区
	- 如何定义时间
		- 地球绕太阳转，一圈24小时
	- 时区(timezone)
		- 时间 = 时间值+所在时区

	- 格林威治时间(GMT)
		- 代表0时区

	- UTC  
		- 国际标准


	- 假如现在中国当地时间晚上8点
		- 20:00 CST（Chinese Standard Time）
		- 12:00 UTC


	- EDT 美国东部夏令时时间
		- 与北京时间的时差是12个小时（比北京晚12个小时）
		- 00:40  EDT
		- 12:40  CST

## 如何设置linux TIme zone
	- linux下glibc
	- /usr/share/zoneinfo

	- zdump  Hongkong


## 如何修改系统时区
	- /etc/localtime  
		- 定义了我么所在local time zone
	1.修改/etc/localtime文件，将/usr/share/zoneinfo找到相对应的时区拷贝到/etc/localtime文件中（也可以用连接去 ）
		[root@localhost ~]# ln -sf /usr/share/zoneinfo/posix/Asia/Shanghai /etc/localtime 
		[root@localhost ~]# 
		[root@localhost ~]# date
		Wed Dec 12 11:34:05 CST 2018
		[root@localhost ~]# 
		
	2.设置TZ环境变量的值
		- tzselect告诉你怎么时区，写法，不会生效
		- 告诉你怎么去写，更显bash后失效



## Real Time Clock（RTC）and System Clock
	- 硬件时间时间时钟（RTC）
		- 硬件时钟是指嵌入在主板上的特殊电路，他的存在就是平时关机之后还可以计算时间的原因
		- 也是操作系统内核用来计算时间的时钟，从1970-1-1 00:00:00
	- 系统时钟（System Clock）


	[root@localhost ~]# date
	Wed Dec 12 11:44:59 CST 2018
	[root@localhost ~]# hwclock --show 
	Wed 12 Dec 2018 07:45:25 PM CST  -0.819866 seconds
	[root@localhost ~]# 


	hwlock --show 查看机器上的硬件时间


	- 把硬件时间设置成系统时间
		- hwclock  --hctosys

	- 把系统时间设置成硬件时间
		- hwclock --systohc

	- 如果想设置硬件时间可以在BIOS设置
		- hwclock --set --date=“mm/dd/yy hh:mm:ss”

	- 修改系统时间
		- date -s "dd/mm/yyyy hh:mm:ss"
	



## 设置NTP server
	- 系统时间与网络时间之间的同步
	- 原子钟


## 利用chrony搭建时间同步服务器
	- 开源的自由软件
	- 保持系统时钟与时钟服务器之间的同步(NTP)
	- chronyd && chronyc
	- chronyd后台运行的守护进程，用于调整内核中运行的系统时钟和时钟服务器同步
	- chronyc提供一个用户界面，用于监控性能并进行多样化的配置


	- chrony优势
		- 同步时间和误差率极小
		- 能够更好的响应时钟频率的快速变化
		- 无需对服务器进行定期的轮询


	- 安装
		- 关闭防火墙和selinux
			- [root@localhost ~]# setenforce 0
		- yum install chrony

	- 启动服务
		- firewall-cmd --permanent --add-service=ntp
		- firewall-cmd --reload
		- [root@localhost yum.repos.d]# systemctl start chronyd
		- [root@localhost yum.repos.d]# systemctl restart chronyd
		- [root@localhost yum.repos.d]# systemctl enable chronyd

	- 配置chrony服务
		- /etc/chrony.conf

	- 使用chronyc
		- activity	该命令显示有多少NTP源在线

		[root@localhost ~]# chronyc activity



## 服务端操作
	- 防火墙selinux
	- 添加服务器地址
	- 重启服务
	- 显示当前时间
		- timedatectl  == timedatectl status
		- 注意NTP NTP synchronized   yes
		- 只有时间服务器自己同步完成后，才能为其他服务器提供时间同步服务

	- 可选操作
		- 设置日期与时间
			- timedatectl set-time "YYYY-MM-DD HH:MM:SS"
			- timedatectl set-time "YYYY-MM-DD"
			- timedatectl set-time "HH:MM:SS"
		- 查看所有可用时区
			- timedatectl list-timezone 
		- 设置时区
			- timedate set-timezone  Asia/Shanghai
		- 设置硬件时间
			- timedatectl set-local-rtc 1   ==  hwlock --systohc --localtime
	- 查看时间源信息
		- chronyc sources
		

## 客户端
	- 安装软件/关闭selinux
	- 修改配置文件
	- 重启服务
	- 查看同步状态   timedatectl


	- 可选手动同步
		- ntpdate server-address
		- 必须把 NTP enabled  设置为no