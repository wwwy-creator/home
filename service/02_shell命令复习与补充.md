## Shell
	硬件
	软件
		系统软件/应用软件
	

## pwd
	显示当前工作目录的名称
	-P	显示链接的真实路径
		[root@server sbin]# ll /
		…………
		lrwxrwxrwx.   1 root root    8 Jul  5 05:58 sbin -> usr/sbin
		drwxr-xr-x.   2 root root    6 Mar 13  2014 srv
		dr-xr-xr-x.  13 root root    0 Nov  1 10:29 sys
		drwxrwxrwt.  23 root root 4096 Nov  1 10:53 tmp
		drwxr-xr-x.  13 root root 4096 Jul  5 05:58 usr
		drwxr-xr-x.  22 root root 4096 Nov  1 10:29 var
		[root@server sbin]# cd /sbin/
		[root@server sbin]# pwd
		/sbin
		[root@server sbin]# pwd -P
		/usr/sbin
		[root@server sbin]# 
## cd
	切换工作目录
		绝对路径法：指哪就是哪
		相对路径法：~/-/.. / .
			[root@server sbin]# cd .
			[root@server sbin]# cd ..
			[root@server /]# cd ~
			[root@server ~]# cd -
			/
			[root@server /]# 

## ls
	列出目录或文件的详细内容
		-l：长格式列出
		-h：显示详细信息（人性化显示内容）
		-a：显示隐藏目录
	补充：
		-c：显示文件或目录属性的最后修改时间
		-u：显示文件或目录最后被访问时间
		-t：已修改时间进行排序，默认按文件名称排序


## touch
	创建一个空文件
## mkdir
	创建目录
	创建单个目录
	若递归创建目录需加-p选项
## cp
	进行本地文件复制
	递归复制整个目录树需加-r选项
	scp/sync/rsync
## mv
	移动文件或者目录
	重命名：在同级目录下移动文件后者目录等同于改名

## rm
	删除文件或者目录
	rm -rf /*(没事可以试试，危险操作记得买好机票，提前办理移民)
	-f:不提示，强制删除
	-i：删除前问你一下是否删除
	-r：删除所有


## cat
	查看文件内容
	-b：显示行号，不显示空白行
	-n：显示行号，包括空行
		  362  vim a.txt
		  363  cat a.txt 
		  364  cat -n  a.txt 
		  365  cat -b a.txt 

## more/less
	分页查看文件内容，空格下一页，回车下一行，q退出


## head/tail
	查看文件头部/尾部多少行内容，默认前/后10行
	-n  显示文件前/后 n 行内容
	-c  nK  显示文件前/后nKB内容
	-f  动态显示文件内容，ctrl+c结束（tail使用，尤其针对于日志）
	

		[root@server ~]# tail -2 initial-setup-ks.cfg 
		%end
		
		[root@server ~]# tail -n 2 initial-setup-ks.cfg 
		%end
		
		[root@server ~]# head -c 1K initial-setup-ks.cfg


## wc
	显示文件的行，单词，字节，统计信息
	wc【选项】【文件】
	-c：统计字节
	-l：统计行数
	-w:统计单词数
		[root@server ~]# wc initial-setup-ks.cfg 
		  49  109 1258 initial-setup-ks.cfg
		[root@server ~]# wc -c initial-setup-ks.cfg 
		1258 initial-setup-ks.cfg
		[root@server ~]# wc -l initial-setup-ks.cfg 
		49 initial-setup-ks.cfg
		[root@server ~]# wc -w initial-setup-ks.cfg 
		109 initial-setup-ks.cfg

## du
	计算文件或目录容量
	du 【选项】【文件/目录】
	-h  显示详细信息
		du -h initial-setup-ks.cfg 

## ln
	1. 软连接
		ln -s /a.txt /tmp/a.txt    #创建文件的软连接
		ln -s  /test   /tmp/test	#创建目录的软连接
	2. 硬连接
		ln /test/hello.sh  /root/hi.sh
		
## wget
	wget用于下载网络文件命令
	wget 【参数】【url下载地址】
		wget https://www.python.org/ftp/python/3.7.1/python371.chm

	-O  下载到指定目录文件名
		wget -O /root/aaa/a.heml https://www.python.org/downloads/release/python-371/
	-c  支持断点续传
	-b  代表后台下载
	--limit-rate	#限速--limit-rate=2.5k
		wget --limit-rate=2.5k https://www.python.org/ftp/python/3.7.1/python371.chm

## elinks
	常用纯文本浏览器
	elinks【选项】【网址】
	yum install elinks -y