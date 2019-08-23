## 补充
	正则匹配出的是其中的某一行，但是想要匹配中的前几行或者后几行
	这时需要控制-A，-B


	-A	打印匹配结果之后的行
	-B	打印匹配结果之前的行
	-C	分别打印出匹配结果之前以及之后的n行



	seq  类似于python中的range

	
	#匹配结果之前的几行   -B
	[root@localhost ~]# seq 10 | grep 5 -B 4
	1
	2
	3
	4
	5
	[root@localhost ~]# seq 10 | grep 5 -B 2
	3
	4
	5
	[root@localhost ~]# 

	#匹配结果之后的几行
	
	[root@localhost ~]# seq 10 | grep 5 -A 2
	5
	6
	7
	[root@localhost ~]# 


	#匹配结果之前以及之后的n行
	[root@localhost ~]# seq 10 | grep 5 -C 2
	3
	4
	5
	6
	7
	[root@localhost ~]#


	#如果有多个匹配结果，可以使用--作为各个部分分割
	[root@localhost ~]# echo -e "a\nb\nc\na\nb\nc" | grep a -A 1
	a
	b
	--
	a
	b
	[root@localhost ~]# 




## 拓展正则表达式（Extended Regular Expression）

	{n,m}	等同于基本正则表达式\{n,m\}
	+       匹配前一个字符出现一次或者多次
	?		匹配前一个字符出现0次或者一次
	|		匹配前/后字串  逻辑或
	()		匹配正则集合

	
	#查找数据0出现1下或者2次的行
	[root@localhost ~]# grep '0{1,2}' /tmp/passwd 
	[root@localhost ~]# egrep '0{1,2}' /tmp/passwd 
	root:x:0:0:root:/root:/bin/bash
	sync:x:5:0:sync:/sbin:/bin/sync
	shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
	halt:x:7:0:halt:/sbin:/sbin/halt
	operator:x:11:0:operator:/root:/sbin/nologin
	games:x:12:100:games:/usr/games:/sbin/nologin
	ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
	avahi:x:70:70:Avahi mDNS/DNS-SD Stack:/var/run/avahi-daemon:/sbin/nologin
	avahi-autoipd:x:170:170:Avahi IPv4LL Stack:/var/lib/avahi-autoipd:/sbin/nologin
	qemu:x:107:107:qemu user:/:/sbin/nologin
	mysql:x:27:1001:MySQL Server:/var/lib/mysql:/bin/false
	hello:x:1000:1000:yuxiang:/home/yuxiang:/bin/bash
	[root@localhost ~]# 

	#查找至少出现一个0的行
		[root@localhost ~]# egrep '0+' /tmp/passwd 
	#查找包含root或者yuxiang的行
		[root@localhost ~]# egrep '(root|yuxiang)' /tmp/passwd 
		root:x:0:0:root:/root:/bin/bash
		operator:x:11:0:operator:/root:/sbin/nologin
		hello:x:1000:1000:yuxiang:/home/yuxiang:/bin/bash






## cut按列切分文件
	cut主要用于按列切分文件，针对csv文件或者说空格分割的文件（标准日志文件）

	1.-f 指定要提取的字段
		cut -f  FILED_LIST  filename

		FILED_LIST 需要显示的列，列号之间用逗号分割
		
		#示例文件
		[root@localhost ~]# cat student_data.txt 
		No	Name	Mark	Percent
		1	Sarath	45	90
		2	Alex	49	98
		3	Anu	45	90
		[root@localhost ~]# 

		#获取文件第2,3列的值
		[root@localhost ~]# cut -f 2,3 student_data.txt 
		Name	Mark
		Sarath	45
		Alex	49
		Anu	45
		[root@localhost ~]# 

	2.cut命令可以从stdin读取输入
		制表符默认为分隔符，对于没有使用分隔符的行，该命令会讲文件原样打印出来。cut的选项-s可以禁止原样打印
			[root@localhost ~]# cut -f2 -s test.txt 
	3.提取多列内容，有分隔符组成字段编号用逗号隔开
			[root@localhost ~]# cut -f2,3 student_data.txt 
	4.可以使用--complement显示出没有被-f指定的字段
		[root@localhost ~]# cut -f1  --complement  student_data.txt 
		Name	Mark	Percent
		Sarath	45	90
		Alex	49	98
		Anu	45	90
		[root@localhost ~]# 
	5.-d指定分隔符
		head -5 /tmp/passwd  | cut -d";" -f 1



## cut内容补充
	指定字段的字节范围


	N-	从第N个字节，字符或者字段开始到行尾
	N-M	从第N个字节，字符或者字段开始到第M个字节(包括M在内)
	-M	从头到第M个字节，字符或者字段


		-b	代表字节
		-c	代表字符
		-f	代表字段

	vim a.txt
	abcdefghiklmnopqrstuvwxyz
	abcdefghiklmnopqrstuvwxyz
	abcdefghiklmnopqrstuvwxyz
	abcdefghiklmnopqrstuvwxyz
	abcdefghiklmnopqrstuvwxyz


	#打印2-5个字符
	[root@localhost ~]# cut -c2-5 a.txt
	#打印前俩个字符
	[root@localhost ~]# cut -c -2 a.txt

	#显示多个区间内容，可以用--output-delimiter设置分隔符
	[root@localhost ~]# cut a.txt -c1-3,6-9  --output-delimiter "……"
