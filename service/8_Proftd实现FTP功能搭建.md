# Proftpd
	- FTP服务端实现的是一种软件或者方式
	- 安全，配置极其简单，容易配置与管理
	- 软件配置类似Apache配置相似的格式
	- wu-ftpd优点


## 安装Proftpd软件
	- ftp://ftp.proftpd.org
	- wget ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.5.tar.gz

	- tar -xzv proftpd-1.3.5.tar.gz  -C /usr/src

	- 安装依赖环境
		- yum install gcc -y

	- 环境编译并安装
	    18  ./configure --prefix=/usr/local/proftpd --sysconfdir=/etc/
   		19  make && make install

	- 添加至环境变量
		- PATH=$PATH:/usr/local/proftd/bin

	- 添加proftp用户
		- useradd -s /sbin/nilogin -M proftp


	- 编译环境检查
		- CONFIGURE部分选项说明
			- --prefix=PREFIX	指定安装路径
			- --sysconfdir=DIR	指定FTP服务配置文件路径
			- --localstatedir=DIR	指定运行状态的文件存放路径
			- --with-modules=mod_Ldap	指定需要加载额功能模块
			- --enable-memcahe	支持缓存功能
			- --enable-nls	支持多语言环境
			- --enable-shadow	支持使用/etc/shadow验证用户密码
			- enable-openssl	支持TLS加密FTP服务




## 配置文件解析
	- vim /etc/proftpd.conf
	- 全局设置
		- 设置全局生效的参数，参数与值使用空格分割
	- 目录设置
		- 指定共享路径以及相关权限设置
		- LImit 设置路径权限
	- 匿名访问设置
		- <anontmous "路径"></anontmous> 设置匿名访问权限以及访问策略



		
		ServerName                      "ProFTPD Default Installation"   #客户端连接后显示的提示字符
		ServerType                      standalone				#服务启动模式，独立后台进程
		DefaultServer                   on				#默认服务器
		Port                            21				#默认监听21号端口
		UseIPv6                         off				#默认禁用IPV6
		Umask                           022				#权限掩码
		MaxInstances                    30				#最大并发连接数
		User                            nobody			#启动服务器账户
		Group                           nogroup			#启动服务器的组账户
	
		AllowOverwrite          on				#是否允许使用文件覆盖权限

		#是否支持断点续传(上传)
		AllowRetrievRestart	on
		#是否支持断点续传(下载)
		AllowStoreRestart	on

		#禁止root用户登陆
		RootLogin	off
		#产生独立的日志文件
		Systemlog	/var/log/proftp.log
		#记录用户下载的日志信息
		TransferLog	/var/log/proftp.log
		
		#权限设置
		<Limit SITE_CHMOD>
		  DenyAll
		</Limit>
		#匿名访问设置，默认为匿名访问
		<Anonymous ~ftp>
		  User                          ftp
		  Group                         ftp
		
		  # We want clients to be able to login with "anonymous" as well as "ftp"
		  UserAlias                     anonymous ftp
		
		  # Limit the maximum number of anonymous logins
		  MaxClients                    10
		
		  # We want 'welcome.msg' displayed at login, and '.message' displayed
		  # in each newly chdired directory.
		  DisplayLogin                  welcome.msg
		  DisplayChdir                  .message
		
		  # Limit WRITE everywhere in the anonymous chroot
		  <Limit WRITE>
		    DenyAll
		  </Limit>
		</Anonymous>



## 权限设置
	- Proftpd可以通过目录属性添加<Limit>的方式设置访问权限
		
		CWD		进入该目录
		MKD		创建目录
		RNFR	更名
		DELE	删除文件
		RMD		删除目录
		READ	可读
		WRITE	可写
		STOR	可上传
		RETR	可下载
		DIRS	允许列出目录
		LOGIN	允许登陆
		ALL		所有
		AllowUser	设置允许账户，多个账号用逗号隔开
		AllowGroup	设置允许的组账号，多个账号逗号隔开
		AllowAll	允许所有
		DenyAll		拒绝所有
		DenyGroup	拒绝组账号，多个账号逗号隔开



## 虚拟用户应用案例

	- ABC
		- 商务部
		- 设计部
		- 研发部
		- 运维部
			- 各个部门访问FTP服务可以看到所有的目录
			- 但是只可以访问本部门的目录
			- 开启FTP日志功能
			- FTP采用基于文件的认证方式
			- 共享目录设置：/vat/ftp



	- 创建启动账户以及共享目录
		[root@server ~]# useradd -M -s /sbin/nologin proftp
		[root@server ~]# mkdir -p /var/ftp/{develop,ops,sales,design}
		[root@server ~]# chmod 777 /var/ftp/{develop,ops,sales,design}
		[root@server ~]# 

	- 修改配置文件
			root@server ~]# vim /etc/proftpd.conf 
			
			# This is a basic ProFTPD configuration file (rename it to
			# 'proftpd.conf' for actual use.  It establishes a single server
			# and a single anonymous login.  It assumes that you have a user/group
			# "nobody" and "ftp" for normal operation and anon.
			
			ServerName                      "ProFTPD Default Installation"
			ServerType                      standalone
			DefaultServer                   on
			DefaultAddress                  192.168.0.10
			
			# Port 21 is the standard FTP port.
			Port                            21
			
			# Don't use IPv6 support by default.
			UseIPv6                         off
			
			# Umask 022 is a good standard umask to prevent new dirs and files
			# from being group and world writable.
			Umask                           022
			
			# To prevent DoS attacks, set the maximum number of child processes
			# to 30.  If you need to allow more than 30 concurrent connections
			# at once, simply increase this value.  Note that this ONLY works
			# in standalone mode, in inetd mode you should use an inetd server
			# that allows you to limit maximum number of processes per service
			# (such as xinetd).
			MaxInstances                    30
			
			# Set the user and group under which the server will run.
			User                            proftp
			Group                           proftp
			
			# To cause every FTP user to be "jailed" (chrooted) into their home
			# directory, uncomment this line.
			#DefaultRoot ~
			DefaultRoot                     /var/ftp
			
			
			# Normally, we want files to be overwriteable.
			AllowOverwrite          on
			
			# Bar use of SITE CHMOD by default
			#<Limit SITE_CHMOD>
			#  DenyAll
			#</Limit>
			
			# A basic anonymous configuration, no upload directories.  If you do not
			# want anonymous users, simply delete this entire <Anonymous> section.
			#<Anonymous ~ftp>
			#  UserAlias                    anonymous ftp
			#
			#  # Limit the maximum number of anonymous logins
			#  MaxClients                   10
			#
			#  # We want 'welcome.msg' displayed at login, and '.message' displayed
			##  # in each newly chdired directory.
			#  DisplayLogin                 welcome.msg
			#  DisplayChdir                 .message
			
			#用户登陆是否开启shell(对虚拟用户狠重要)
			RequireValidShell       off
			AuthUserFile            /usr/local/proftpd/ftpd.passwd
			<Directory "/var/ftp/*">
			<Limit CWD READ>
			    AllowAll
			</Limit>
			</Directory>
			
			<Directory "/var/ftp/ops">
			<Limit CWD MKD RNFR READ WRITE STOR RETR>
			    DenyAll
			</Limit>
			</Directory>
			
			
			
			    AllowUser jack,jacob
			</Limit>
			</Directory>
			
			
			
			<Directory "/var/ftp/sales">
			<Limit CWD MKD RNFR READ WRITE STOR RETR>
			    DenyAll
			</Limit>
			<Limit DELE>
			    DenyAll
			</Limit>
			<Limit CWD MKD RNFR READ WRITE STOR RETR>
			    AllowUser sales1
			</Limit>
			</Directory>
			
			
			
			<Directory "/var/ftp/design">
			<Limit CWD MKD RNFR READ WRITE STOR RETR>
			    DenyAll
			</Limit>
			<Limit DELE>
			    DenyAll
			</Limit>
			<Limit CWD MKD RNFR READ WRITE STOR RETR>
			    AllowUser design1
			</Limit>
			</Directory>
	- 创建虚拟用户账户
		- 创建访问FTP所需要的账户和密码
		- pftpasswd
		
		用法：
			创建用户文件，组文件，迷人创建用户文件ftpd.passwd
		选项：
			--passwd	创建密码文件，AuthUserFile指定的文件
			--group		创建组文件
			--name		创建用户名
			--uid		创建虚拟uid
			--gid		创建虚拟组id
			--home		指定用户家目录
			--shell		指定用户shell
			--file		指定创建文件名，默认ftpd.passwd


		34  ftpasswd --passwd --name=harry --uid=1001 --gid=1001 --home=/home/nohome --shell=/bin/false
	   35  ftpasswd --passwd --name=jacob --uid=1002 --gid=1002 --home=/home/nohome --shell=/bin/false
	   36  ftpasswd --passwd --name=jack --uid=1003 --gid=1003 --home=/home/nohome --shell=/bin/false
	   37  ftpasswd --passwd --name=sales1 --uid=1004 --gid=1004 --home=/home/nohome --shell=/bin/false
	   38  ftpasswd --passwd --name=design1 --uid=1005 --gid=1005 --home=/home/nohome --shell=/bin/false
	- 启动proftpd服务
		