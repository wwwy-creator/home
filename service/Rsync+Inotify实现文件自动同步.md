## 利用rsync定义实现数据的备份
	- 定期实现
		- 将脚本扔到计划任务中，进行周期执行
	- rsync脚本编写
		- #!/bin/bash
		#This script does backup through rsync.
		
		export PATH=/bin:/usr/bin:/usr/local/bin
		SRC=common
		DEST=/data
		Server=192.168.0.10
		User=Tom
		Passfile=/root/rsync.pass
		[ ! -d $DEST ] && mkdir $DEST
		[ ! -e $Passfile ] && exit 2
		rsync -az --delete --password-file=${User}@${server}::$SRC $DEST/$(date +%Y%m%d)


## Rsync+Inotify实现文件自动同步
	- 集成在linux内核中
	- Inotify为用户态应用程序提供文件系统事件的通告机制

	- 常见文件系统事件
		- IN_ACCESS	文件访问事件
		- IN_MODIFY	文件修改事件
		- IN_ATTRIB	文件属性修改事件
		- IN_OPEN	文件打开事件
		- IN_CLOSE_WRITE	可写文件被关闭事件
		- IN_CLOSE_NOWRITE	不可以文件被关闭事件
		- IN_MOVED_FROM
		- IN_MOVED_TO	文件移动/文件冲命令事件
		- IN_DELETE		文件或目录的被删除事件
		- IN_CREATE		文件或目录被创建事件
		- IN_DELTET_SELF	文件自删除事件


	- 软件安装
		- https://github.com/rvoicilas/inotify-tools
		- 安装依赖包
			- yum install automake libtool -y
		- unzip inotify-tools-master.zip
		- cd inotify-tools-master/
		- ./autogen.sh configure.ac
		- ./configure 
		- make && make install
		- inotifywait --help


## 监控数据
	- inotify-tools提供了俩个应用程序
		- inotifywait
		- inotifywatch
	- inotifywait命令的描述与使用
		- 描述：
			- 使用inotify机制等待文件系统系统事件，实时监控文件系统的变化
		- 用法
			- inotifywait [-hcmrq] [-e <event> ] [-t <seconds> ] [--format <fmt> ] [--timefmt <fmt> ] <file> [ ... ]
		- 选项：
			- h,--help 显示帮助信息
			- @file	指定监控路径中的例外文件，应用不需要监控的文件
			- fromfile <file>  从问价中读取需要监控与例外的文件名称，每行一个文件名，如果文件名称以@开头，则表示例外文件
			- -m, --monitor  接受到事件后不退出，默认程序在接受一个事件后退出
			- -d, --daemon 与-m类似，但程序会进入后台执行，需要通过--outfile指定时间信息输出文件
	- 应用案例
		- 创建测试目录/test和测试文件/etc/foo，运行inotifywait命令监控/test目录，然后开启一个终端窗口运行命令cat /test/foo，验证发生查看文件事件后，是否会有事件通知
		- [root@localhost inotify-tools-master]# mkdir -p /test;echo "hello" > /test/foo
		[root@localhost inotify-tools-master]# inotifywait /test/
		Setting up watches.
		Watches established.
		/test/ OPEN foo
		[root@localhost inotify-tools-master]# 


	- 编写一个脚本实时监控NetworkManagers相关日志信息
		- 
		[root@localhost ~]# cat monitor。sh 
		#!/bin/bash
		
		while inotifywait -e modify /var/log/messages
		do
		if tail -n1 /var/log/messages | grep NetworkManager
		then
		    echo hello
		fi
		done
		[root@localhost ~]# 


## Rsync&&Inotigy实现
	192.168.0.10 web服务器配置
		[root@localhost ~]# mkdir -p /var/www/001
		[root@localhost ~]# chmod 660 /var/www/001/
		[root@localhost ~]# chown nobody:nobody /var/www/001/


		vim /etc/rsyncd.conf
			uid = nobody
			gid = nobody
			use chroot = yes
			# max connections = 4
			pid file = /var/run/rsyncd.pid
			log file = /var/log/rsyncd.log
			lock file = /var/run/rsyncd.lock
			ignore error
			# exclude = lost+found/
			# transfer logging = yes
			# timeout = 900
			# ignore nonreadable = yes
			# dont compress   = *.gz *.tgz *.zip *.z *.Z *.rpm *.deb *.bz2
			
			# [ftp]
			#        path = /home/ftp
			#        comment = ftp export area
			[web1]
			    comment = web content
			    path = /var/www/001
			    auth users = tom
			    secrets file = /etc/rsyncd.secrets
			    hosts allow = 192.168.0.0/255.255.255.0
			    hosts deny = *
			    list = false

		
		root@localhost ~]# echo "tom:123" > /etc/rsy
		rsyncd.conf   rsyslog.conf  rsyslog.d/    
		[root@localhost ~]# echo "tom:123" > /etc/rsyncd.secrets
		[root@localhost ~]# chmod 600 /etc/rsyncd.secrets 
		[root@localhost ~]# rsync --daemon
		[root@localhost ~]# echo "rsync --daemon" >> /etc/rc.local 
		[root@localhost ~]# firewall-cmd --permanent --add-port=873/tcp
		[root@localhost ~]# firewall-cmd --reload


	# 搭建数据发布服务器
	  122  mount /dev/cdrom /mnt/cdrom/
	  123  yum install automake libtool -y
	  124  ls
	  125  unzip inotify-tools-master.zip 
	  126  cd inotify-tools-master/
	  127  ls
	  128  ./autogen.sh configure.ac 
	  129  ./configure 
	  130  make && make install

	构建脚本
	
	#!/bin/bash
	
		#!/bin/bash
	
	export PATH=/bin:/usr/bin:/usr/local/bin
	
	SRC=/web_data/
	DEST1=web1
	DEST2=web2
	Client=192.168.0.20
	User=tom
	Passfile=/root/rsync.pass
	[ ! -e $Passfile ] && exit 2
	inotifywait -mrq --timefmt '%y-%m-%d %H:%M' --format '%T %w%f %e' --event modify,create,move,delete,attrib $SRC | while read line
	do
	echo "$line" > /var/log/inotify_web 2>&1
	/usr/bin/rsync -avz --delete --progress --password-file $SRC ${User}@Client::$DEST1 >> /var/log/sysn_web1 2>&1
	done

