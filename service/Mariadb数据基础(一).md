# Mariadb
	- 数据库(DataBase)
		- 数据存储的仓库
		- 数据库管理系统
## 常见数据库版本
	- 甲骨文Oracle（OCP、OCM）
	- IBM DB2
	- 微软Access和Sql Server
	- mysql
	- PostgreSQL
	- Mairadb

## 为什么选择Mairadb数据库
	- Mysql有走向封闭的趋势
	- Mysql发展缓慢
	- MairaDB对mysql的高度兼容


## 获取与使用Mairadb
	- https://downloads.mariadb.org
	-  成熟版本主要分为10系列和5系列
	-  Mairadb各种安装包
		-  源码包
		-  压缩包
		-  安装包
## Mairadb的安装
	RHEL/Centos/Fedora		RPM软件包
	Ubuntu/Debian		Deb软件包
	- rhel系统下安装mairadb
		- mariadb-server	Mariadb服务器相关文件(必须)
		- mairadb-client	客户端软件包
		- mairadb-test	mariadb一起分发的测试套件
		- mairadb-bench		Mairadb基准测试脚本和数据
	- 安装
		- yum groupinstall mairadb mariadb-client -y
	- 启动服务
		- systemctl restart mariadb
		- systemctl enable mariadb
		- systemctl status mariadb
			- Loaded:	显示该服务是否已经加载和启用
			- Active:	显示该服务是否已经激活
			- Main PID：		显示该服务主进程
			- CGroup:	显示该服务的所有进程
	- 注意：
		- /etc/my.cnf
			- 放置Mairadb默认配置
				- 数据目录
				- 套接字绑定
				- 日志和错误文件位置
		- /var/log/mariadb/mariadb.log   默认的日志文件


## 提高Mairadb安装安全性
	- 提供了一个程序以提高基线安装状态中的安全性
		- mysql_secure_installation
	- 设置root账户的密码
	- 删除了anonymous
	- 删除可以从本地主机访问外部的root账户
	- 删除test数据库



## 远程访问数据库
	- 配置/etc/my.cnf
		- [mysqld]
			- bind-address 0.0.0.0
	- 防火墙允许mairadb远程访问
		- 防火墙允许3306端口通过
			- firewall-cmd --permanent --add-port=3306/tcp
			- firewall-cmd --reload
	- 设置root用户远程访问
		- select User,host from mysql.user;
		- GRANT ALL PRIVILEGES ON *.*  TO 'root'@'%' IDENTIFIED BY 'redhat' WITH GRANT OPTION;
		- GRANT ALL PRIVILEGES ON *.*  TO 'root'@'192.168.0.%' IDENTIFIED BY 'redhat' WITH GRANT OPTION;
		- FLUSH PRIVILEGES;

## Mairadb数据库基础维护
	- Mairadb数据类型
		- 数据类型是数据的一种属性，决定了数据的存储格式有效范围和相应的限制
		- 整数类型，浮点数类型和定点数类型
			- int 4(字节)
			- float	4
			- double	8
			- decimal(M,D) 定点数   M+2
				- float（6,2）	数据长度为6，小数2位   1234.56
		- 日期与时间类型
			- year	1	1901~2155	0000
			- date	4	1000~01~01 ~ 9999~12~31		0000:00:00
			- -time	3	-838:59:59~838:59:59	00:00:00
			- DATETIME	8 	1000-01-01 00：00:00 ~ 9999-12-31 23:59:59	0000-00-00 00:00:00
			- TIMESTAMP	4 19700101080001~20380119111407	00000000000000
		- 字符串类型
			- char/varchar
				- char(6)  varchar可变
			- text	特殊的字符串类型  只保存字符数据，新闻等等
			- ENUM	枚举		属性名 ENUM（值1,2,3，4）
			- SET类型 属性名 SET（值1,2,3，4）  可以得到多个值，以列表方式保存
		- 二进制类型
			- 在数据库中存储方式为二进制
			- 主要包括binary,varbinary,bit,blob等等
			- BLOB:特殊二进制类型，只存储图片，PDF等
			- BIT(M):M位的二进制数据，M最大为64
			- binary(M):字节数为M，允许长度为0~M的定长二进制字符串串
	- 操作数据库
		- 库的创建，修改和删除
		- 表的增删改查
		- 索引
		- 视图
		- 触发器
		