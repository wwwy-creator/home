## shell中的引号
	* $

## 反斜线
	反斜线跟在某个字符前面，示意为转义，显示该字符原有含义
	*  代表任意的    \*
	

	\	还代表回车换行，实现多行输入

	echo *   	#打印当前目录下所有的文件
	echo \*		#打印*字符
	
	echo \>		#打印大于号
	[root@localhost ~]# find / \
	> -name "*.txt"  \
	> -type f  \
	> -size +1M
	/usr/share/perl5/Unicode/Collate/allkeys.txt
	/usr/share/libhangul/hanja/hanja.txt
	/usr/share/hwdata/oui.txt
	[root@localhost ~]#  



### 单引号
	单引号可以将它中间的所有任意字符还原为字面意思，实现屏蔽shell元字符的功能
	'**'**' #单引号再次成对出现
	
	[root@localhost ~]# echo $HOME
	/root
	[root@localhost ~]# echo '$HOME'
	$HOME
	[root@localhost ~]# echo "$HOME"
	/root
	[root@localhost ~]# echo "\$HOME"
	$HOME
	[root@localhost ~]# echo 'hello'
	hello
	[root@localhost ~]# echo 'hello\'
	hello\
	[root@localhost ~]# 

## 双引号
	类似单引号，但是跟单引号略微有不同
	他不会屏蔽  ` \  $  这三个元字符含义
	若想屏蔽元字符含义需加转义字符

	[root@localhost ~]# echo "Hello world"
	Hello world
	[root@localhost ~]# echo "My name's BJTLXY."
	My name's BJTLXY.
	[root@localhost ~]# echo "$HOME"
	/root
	[root@localhost ~]# echo "\$HOME"
	$HOME
	[root@localhost ~]# 



## 反引号
	反引号主要进行命令替换
	#该功能可以使用$()来替换
	[root@localhost ~]# echo "Today is `date +%D`"
	Today is 11/14/18
	[root@localhost ~]# echo "Today is $(date +%D)"
	Today is 11/14/18
	[root@localhost ~]# 
