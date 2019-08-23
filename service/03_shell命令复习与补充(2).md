## find
	用于查找文件或者目录
	-size	按文件大小查找
	-empty	查找空白文件或者目录
	-name	按文件名称查找
	-iname	按照文件名称查找，不分区大小写
	-user	按照文件属主查找
	-group	按照文件属组进行查找
	-mtime	按文件修改时间进行查找
	-type	按照文件类型进行查找（f,d,b,c,l）
	-a	并且
	-o	或者
	find常与管道符，-exec，xargs进行联合使用
	
		[root@server ~]# find /root/  -name '*.txt' -type f | xargs ls -l
		[root@server ~]# find /root/ -name '*.txt' -type f -exec ls -l {} \;
		[root@server ~]# find / -size +1M -a -type f
		[root@server ~]# find / -empty
		[root@server ~]# find / -group yuxiang
		
		#查找系统中三天内被修改的文档
			find / -mtime -3
		#查找系统中三天前被修改的文档
			find / -mtime +3
		#查找系统中俩天前的当天被修改的文档
			find / -mtime  2


## grep
	查找关键词并打印匹配的行
	grep [选项]【匹配模式】【文件】
		-i 	忽略大小写
		-v	反转查找
		-w	匹配单词
		--color	显示颜色

		[root@server ~]# grep -w boot initial-setup-ks.cfg
		[root@server ~]# grep -w -v boot initial-setup-ks.cfg | grep 'boot'




## 压缩与解压缩
	1.gzip	
		gzip 【选项】 【文件名称】
		-d	解压
			[root@server ~]# gzip initial-setup-ks.cfg
			[root@server ~]# gzip -d initial-setup-ks.cfg.gz
	2.bzip2
		[root@server ~]# bzip2 initial-setup-ks.cfg
		[root@server ~]# bzip2 -d initial-setup-ks.cfg.bz2
		
	#注意：gzip与bzip2不能针对目录进行压缩

	3.tar
		tar [选项]【压缩路径+压缩名称】【压缩的文件或者目录】


		-c	压缩
		-x	解压缩
		-z	格式为gzip格式
		-j	格式bzip2格式
		-f	指定压缩后的文件名称
		-C	指定解压路径
		-t	列出打包文件的详细信息
		--delete	删除压缩文件中的内容	
		--remove	压缩后删除源文件
	
			tar cf etc.tar /etc
			tar tvf etc.tar | grep /etc/hosts
			tar --delete etc/hosts -f etc.tar

			#追加文件至压缩文件
			[root@server ~]# tar -f etc.tar -r /root/initial-setup-ks.cfg

			#压缩后删除源文件
			[root@server ~]# tar -czvf init.tar.gz initial-setup-ks.cfg --remove-files
			#解压缩
			[root@server ~]# tar -xzvf init.tar.gz -C .
			
			
	
		
## echo
	用于在终端显示字符串或者变量
	echo [字符串|变量]
	-n	不输出换行，默认换行
	-e	支持反斜线开始的转义字符
		\\  反斜线
		\a	报警器
		\b	退格键
		\c	不格外输出，不换行
		\n	换行
		\f	表单
		\t	水平tab
		\v	垂直tab

		[root@server ~]# echo $SHELL
		[root@server ~]# echo $HOSTNAME
		[root@server ~]# echo hello world
		[root@server ~]# echo "hello world"
	
		  443  echo -e "\a"
		  444  echo -e "11\b22"
		  445  echo -e "12\b34"
		  446  echo -e "hello\c"
		  447  echo -e "\n"
		  448  echo -e "\nscdsacdasd"
		  449  echo -e "I\fHava\fa\fdream"
		  450  echo -e "hello\tworld"
		  451  echo -e "hello\vworld"


## date	
	date用于显示/设置系统时间日期
	date[选项][+指定格式]
	
		%t	tab
		%H	小时（00:23）
		%I	小时(01:12)
		%M	分钟（00-59）
		%S	秒（00-60）
		%X	相当于%H:%M:%S
		%Z	显示时区
		%p	显示AM|PM
		%A	星期几(Sunday-Saturday)
		%a	星期几（Sun-Sat）
		%B	月份（January-December）
		%b	月份（Jan-Dec）
		%d	天（1-31）
		%m	月份（01-12）
		%Y	完整的年份
		%j	一年中的第几天（001-366）

			  457  date "+%j"
			  458  date "+%Y-%m-%d %H:%M:%S"
			  459  date -s "20190101 00:00:00"
			  462  date "+%Z"
			  464  date "+%A"
			  466  date "+%p"




## uname
	用于查看系统内核版本信息
	uname -a
	vim /etc/redhat-release

## uptime	
	查看系统负载情况
	uptime
	[root@server ~]# watch -n -1 uptime


## free	
	显示系统当前内存使用情况
	free -m
	

## df
	监控磁盘使用情况
	-h  详细信息
	-i	显示磁盘节点信息
	-T	显示文件系统类型
	

## ifconfig
	[root@server ~]# ifconfig eno16777728
	[root@server ~]# ifconfig eno33554968 192.168.0.222 netmask 255.255.255.0
	ifconfig eno33554968 down/up


## netstat
	打印网络连接，路由表，网络接口统计信息
	-n	使用数字形式的IP，端口号，用户ID代替主机，协议，用户等信息
	-u	查看udp链接
	-t	查看tcp连接
	-l	仅仅显示正在监听的接口信息
	-p	显示进程名称和进程ID号


	[root@server ~]# netstat -nutlp | grep 3306


## ps
	-e 查看所有进程信息
	-f	全格式显示
	ps aux
	
	[root@server ~]# ps -ef | grep 3306

## top
	动态查看进程信息
	-d	设置进程信息刷新间隔时间
	-p	查看指定PID号的进程信息
	top -d 1 -p 1,2




群号：726850851
	

注意：认认真真看我们群公告