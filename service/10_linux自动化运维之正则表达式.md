## 正则表达式（grep/egrep）
	则表达式是对字符串操作的一种逻辑公式，就是用事先定义好的一些特定字符、及这些特定字符的组合，组成一个“规则字符串”，这个“规则字符串”用来表达对字符串的一种过滤逻辑《百度百科》

## 常用正则表达式及含义
	[ 正则表达式手册 ](http://tool.oschina.net/uploads/apidocs/jquery/regexp.html)
	[30分钟入门教程](https://www.jb51.net/tools/zhengze.html)
	[菜鸟教程](http://www.runoob.com/regexp/regexp-tutorial.html)

	
	as		匹配字母as
	.		匹配任意字符
	*   	匹配前一个字符出现0次或者多次
	+	    匹配前一个字符出现1次或者多次
	？		匹配前一个表达式匹配0次或者一次，取消贪婪模式
	.*		贪婪模式	匹配任意多个任意字符
	[]		匹配集合中任意单个字符，括号中为集合   [adc]
	[a-z]		匹配集合中的范围
	^		匹配字符串的开头
	$		匹配字符串额结尾
	[^……]	匹配否定，类似取反
	|		匹配竖线俩遍的任何一个
	\		转义字符，匹配转义后的字符串
	\{n,m\}		匹配前一个字符重复出现n到m次
	\{n,\}		匹配前一个字符重复出现至少n次
	\(\)		将\(与\)之间的内容存储在"保留空间，最大存储9个"
	\n			通过\1\9调用保留空间中的内容


	


	[root@localhost ~]# grep "root" /tmp/passwd 
	root:x:0:0:root:/root:/bin/bash
	operator:x:11:0:operator:/root:/sbin/nologin


	#查找包含oot或ost的行
	grep o[os]t /tmp/passwd

	#查找包含数据0-9的行
	grep [0-9]  /tmp/passwd
	grep [f-q]  /tmp/passwd

	
	#
	grep ^root	/tmp/passwd

	grep  bash$ /tmp/passwd


	#查找sbin/后面不跟n的行
	grep sbin/[^n]  /tmp/passwd

	#查找数字0出现一次，俩次的行
	grep  '0\{1,2\}' /tmp/passwd

	#查找包含俩个root的行
	grep "\(root\).*\1" /tmp/passwd

	#查找包含以root：开头的行，并以：root结尾的行

	grep "\(root\)\(:\).*\2\1"  /tmp/passwd


	#匹配空白行
	grep ^$ /tmp/passwd
	
	#匹配非空白行
	grep -v ^$ /tmp/passwd
	