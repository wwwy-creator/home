# Rsync文件同步
	Rsync（remote sync）
	- 是unix或者类unix操作系统之间一款数据镜像备份软件
	- 差异备份
	- ssh安全隧道进行数据加密
	- 873 TCP


## 搭建rsync服务器
	- yum install rsync
	- rsync主要分为三个配置文件
		- rsyncd.conf	主配置文件
		- rsyncd.secrets  密码文件
		- rsync.motd	服务信息文件



	- vim /etc/rsyncd.conf
		#设置服务器信息提示文件名称，在该文件中编写提示信息
		motd file = /etc/rsyncd.moted
		#开启rsync数据传输日志功能
		transfer logging = yes
        #设置日志文件名称，log format
		log file = /var/run/rsyncd.log
		#设置rsync进程号保存文件名称
		pid file = /var/run/rsyncd.pid
		#设置锁文件名称
		lock file = /var/run/rsyncd.lock
		#设置侦听端口号
		port 873
		#设置侦听地址
		address = 192.168.0.10
		设置进行数据传输时所用的账户名称和ID号
		uid = nobody
		gid = nobody
		use chroot = no
		#是否允许客户端可写
		read only = yes
		#最大并发连接数，0代表无限制
		max connections = 10
		[common]
		    comment = Web content
		    path = /common
			#忽略一些IO参数
		    ignore errors
		    #exclude = dir
			#认证用户
		    auth users = tom,jerry
			#密码文件
		    secrets file = /etc/rsyncd.secrets
			#允许访问的地址段
		    hosts allow = 192.168.0.0/255.255.255.0
			#拒绝的地址段，除hostsallow
		    hosts deny = *
			#客户端请求显示模块列表时，本模块名称是否显示，默认为true
		    list = false

	- 设置密码文件/etc/rsyncd.secrets
		[root@server ~]# echo "tom:pass" > /etc/rsyncd.secrets
		[root@server ~]# echo "jerry:pass" >> /etc/rsyncd.secrets
		[root@server ~]# chmod 600 /etc/rsyncd.secrets
	- 写入提示信息
		-  echo "Welcome to access" > /etc/rsyncd.motd
	- 防火情允许端口通过
		- [root@server ~]# firewall-cmd --permanent --add-port=873/tcp
		[root@server ~]# firewall-cmd --reload
	- 开启服务
		- rsync --daemon
		- echo "/usr/bin/rsync --daemon" >> /etc/rc.local



## 客户端操作
	- 客户端进行数据同步
	- yum install rsync
	- rsync -vzrtopg --progress tom@192.168.0.10::common /common


	

## rsync命令描述与使用
	- 描述
		- 一个快速，多功能的远程(或本地)数据复制工具
	- SRC
		- 表示源路径
	- DEST
		- 表示目标路径
	- 本地复制
		- rsync [选项] SRC ...[DEST]
		- scp -r SRC...[DEST]
	- 通过远程shell复制
		- 下载数据
			- rsync [选项] [user@]HOST:SRC ... [DEST]
		- 上传数据
			- rsync [选项] ...[user@]HOST:DEST
	- 通过rsync进程复制
		- 下载数据
			- rsync [选项] [USER@]HOST::SRC ...[DEST]
			- rsync [选项] rsync://[USER@]HOST[:PORT]/SRC ...[DEST]
		- 上传数据
			- rsync [选项] SRC ...[USER@]HOST::DEST
			- rsync [选项] SRC...rsync://[USER@]HOST[:PORT]/DEST.

	- 选项
		1. -v, --verbose	显示详细信息
		2. -q, --quiet		静默模式，无错误信息
		3. -a, --archive	归档模式，主要保留文件属性，等同于-rlptgoD
		4. -r, --recursive	递归
		5. -b, --backup	如果目标路径存在同名文件，将旧的文件重命名为~filename,可以使用--suffix指定不同的备份前缀
		6. --backup-dir=DIR  将备份文件保存指定目录
		7. --suffix=SUFFIX	指定备份前缀
		8. -u, --update	如果目标中的文件比将要下载的文件新，则不执行同步
		9. -l, --links	保留符号连接
		10. -p, --perms	保留文件权限属性
		11. -H, --hard-links	保留硬连接
		12. -z，--compress	传输过程中对数据进行压缩
		13. -t, --times，保留修改时间属性


	- 举例
		- 将本机当前目录下以.cfg结尾的文件复制到client主机下的scr目录下
			- rsync -t *.cfg client:src/
		- 从server主机递归方式将/mnt/cdrom目录下的所有内容复制到本机的/data/tmp目录下，但在/data/tmp目录下不会创建cdrom目录
			- rsync -avz /mnt/cdrom /data/tmp
			- rsync -avz server:/mnt/cdrom /data/tmp
		- 使用tom用户远程连接192.168.0.10主机的rsync进程，将common模块定义的path路径下载至本地/test目录
			- rsync -avz tom@192.168.0.10::common /test
		- 匿名下载192.168.0.10服务器的common模块至/test1目录
			- rsync -avz 192.168.0.10::common /test1
		- 显示192.168.0.10服务器所有模块名称
			- rsync --list-onlty tom@192.168.0.10::
		- 客户端每次连接都需要输入民吗信息显的非常麻烦，可以将密码文件放置在rsync.pass，使用rsync命令--password-file参数指定密码文件
			- 预留