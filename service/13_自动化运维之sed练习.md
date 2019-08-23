# sed命令集练习


- 案例文件

[root@localhost ~]# cat quote.txt
The honeysuckle band played all night long for inly $90.
It was an evening of splendid music and company.
Too bad the disco floor fell through at 23:10.
The local nurse MIss P.Neave was in attendance.
[root@localhost ~]# 

## 使用p(rint)显示行
	
	[root@localhost ~]# sed '2p' quote.txt 
		The honeysuckle band played all night long for inly $90.
		It was an evening of splendid music and company.
		It was an evening of splendid music and company.
		Too bad the disco floor fell through at 23:10.
		The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# sed -n '2p' quote.txt 
		It was an evening of splendid music and company.
	[root@localhost ~]# 


## 打印范围
	number：指定输入文件的唯一行号
	number1，number2：'1,3p' 匹配number1到number2支间的所有行
	first~step：指定从first行开始，每个step几行打印
	$:代表最后一行
	addr1，+N：匹配addr1以及后面的N行内容
	/regexp/ 匹配正则

	[root@localhost ~]# sed -n '1,3'p quote.txt 
	[root@localhost ~]# sed -n '1~2p' quote.txt 
	[root@localhost ~]# sed -n '1,+1'p quote.txt 


## 打印匹配模式
	/pattern/:匹配模式
	#匹配单词evening，并打印此行
	[root@localhost ~]# sed -n '/evening/p' quote.txt 
	It was an evening of splendid music and company.
	[root@localhost ~]# 


## 使用模式和行号进行查询
	为编辑某个问价时，sed返回指定单词的许多行，为了返回结果更加精确，我们可以将行号和模式进行结合
	使用模式与行号混合方法时：格式为：
	line_number,/patter/   #行号与匹配逗号隔开
	[root@localhost ~]# sed -n '/The/p' quote.txt
	[root@localhost ~]# sed -n '4,/The/p' quote.txt

## 匹配元字符
	$
	对于元字符，使用转义字符\屏蔽其原有含义
	/\$/p

	[root@localhost ~]# sed -n '/\$/'p quote.txt


## 显示整个文件
	从第一行匹配到最后一行    1,$
	
	[root@localhost ~]# sed -n '1,$'p quote.txt


## 显示任意字符
	匹配任意字母，
	.*ing

	[root@localhost ~]# sed -n '/.*ing/'p quote.txt



## 打印首行
	打印文件第一行
	sed -n '1p'  quote.txt


##  打印最后一行
	sed -n '$'p  quote.txt



## 打印行号
	/pattern/=

	[root@localhost ~]# sed -n '/music/=' quote.txt 
	2
	[root@localhost ~]# sed -n '/music/p' quote.txt 
	It was an evening of splendid music and company.
	[root@localhost ~]# sed -n -e '/musci/p' -e '/musci/=' quote.txt 
	[root@localhost ~]# sed -n -e '/music/p' -e '/music/=' quote.txt 
	It was an evening of splendid music and company.
	2
	[root@localhost ~]# cat -n quote.txt 
	     1	The honeysuckle band played all night long for inly $90.
	     2	It was an evening of splendid music and company.
	     3	Too bad the disco floor fell through at 23:10.
	     4	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# sed -e '/music/=' quote.txt 
	The honeysuckle band played all night long for inly $90.
	2
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# 


## 文本追加
	a/  附加文本
	可以指定文本一行或多行附加到指定行，若不指定文本放置位置，缺省放置在每一行后面
	格式：
		[address]a\text\text\text\
			

		root@localhost ~]# sed "/company/a\I love Beijing Tian'anmen " quote.txt 

		[root@localhost ~]# sed "a\I love Beijing Tian'anmen " quote.txt 

## 利用脚本进行追加
	[root@localhost ~]# vim add.sed
	[root@localhost ~]# cat add.sed 
	#!/bin/sed -f
	/company/a\
	I love my gril friend. \
	I love myself.
	[root@localhost ~]# 
	
	[root@localhost ~]# chmod u+x add.sed 
	[root@localhost ~]# ./add.sed 

	[root@localhost ~]# ./add.sed  quote.txt 
	The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	I love my gril friend. 
	I love myself.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# 


## 插入文本
	i/  插入文本
	插入文本类似于附加文本，只是在指定行前插入
	[root@localhost ~]# vim insert.sed
	[root@localhost ~]# cat insert.sed 
	#!/bin/sed -f
	4 i\
	Welcome to Beijing Tu Ling XueYuan 
	[root@localhost ~]# 

	[root@localhost ~]# chmod u+x insert.sed 
	[root@localhost ~]# ./insert.sed quote.txt 
	The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	Welcome to Beijing Tu Ling XueYuan 
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# 



## 修改文本
	[address[,address]] c\
	text/
	text/
	………………

	[root@localhost ~]# vim cha.sed
	[root@localhost ~]# chmod +x cha.sed 
	[root@localhost ~]# ./cha.sed quote.txt 
	北京图灵学院欢迎您！
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# cat -n quote.txt 
	     1	The honeysuckle band played all night long for inly $90.
	     2	It was an evening of splendid music and company.
	     3	Too bad the disco floor fell through at 23:10.
	     4	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# cat -n cha.sed 
	     1	#!/bin/sed -f
	     2	/honeysuckle/ c\
	     3	北京图灵学院欢迎您！
	[root@localhost ~]# 


## 针对于同一个文件可以对脚本进行混合操作
	[root@localhost ~]# vim Supper.sed
	[root@localhost ~]# 
	[root@localhost ~]# cat Supper.sed 
	#!/bin/sed -f
	1 c\
	北京图灵学院欢迎您~~~
	
	
	/evening/  i\
	欢迎来到北京图灵学院学习~~~
	
	
	3 a\
	我们的课程包含python,java,数据分析，前端，php,linux
	
	
	
	$ c\
	北京图灵学院祝愿学业有成~~
	[root@localhost ~]# chmod u+x Supper.sed 
	[root@localhost ~]# ./Supper.sed quote.txt 
	北京图灵学院欢迎您~~~
	欢迎来到北京图灵学院学习~~~
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	我们的课程包含python,java,数据分析，前端，php,linux
	北京图灵学院祝愿学业有成~~
	[root@localhost ~]# 


	
## 删除文本
	格式:
	[address[,address]]d   #可以是的行也可以是匹配
	
	删除第一行：
	删除最后一行：
	使用正则进行删除：
	

	[root@localhost ~]# sed '1d' quote.txt 
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# sed '$d' quote.txt 
	The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	[root@localhost ~]# sed '/music/d' quote.txt 
	The honeysuckle band played all night long for inly $90.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# 


## 替换文本
	格式：
	[address[,address]] s\ x/y/[gpwn]
	
	s  通知sed为替换操作，查询x，替换为y

	g	全局替换，默认替换第一次匹配到的
	p	标准输出，加p使-n不生效
	w	替换输出文件为，另存为
	

	#替换company为COMPANY
	[root@localhost ~]# sed 's/company/CONMPANY/' quote.txt

	#替换小写the
	[root@localhost ~]# sed 's/The/the/' quote.txt 

	[root@localhost ~]# sed 's/The/the/' quote.txt 
	the The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	the local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# sed 's/The/the/g' quote.txt 
	the the honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	the local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# 


	#从$90中删除$符号
	[root@localhost ~]# sed 's/\$//' quote.txt 
	The The honeysuckle band played all night long for inly 90.
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# 


	#文件另存为
	w 存储数据文件
	[root@localhost ~]# sed 's/splendid/HELLO/' quote.txt  > sed.out
	

	[root@localhost ~]# sed 's/splendid/HELLO/w' quote.txt
	sed: couldn't open file : No such file or directory
	[root@localhost ~]# sed 's/splendid/HELLO/w sed.out' quote.txt
	The The honeysuckle band played all night long for inly $90.
	It was an evening of HELLO music and company.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# cat sed.out 
	It was an evening of HELLO music and company.
	[root@localhost ~]# 




## 使用替换修改字符串
	如果要附加或修改一个字符串，可以使用(&)命令
	&命令保存发现模式，以便重新调用，然后把他放在替换字符串里面
	先给出一个被替换模式，然后是一个准备附加在第一个模式后的另一个模式，并且后面带有&，这样修改模式将放在匹配模式之前
	

	[root@localhost ~]# sed -n 's/floor/FLLOR &/p' quote.txt
	[root@localhost ~]# sed -n 's/band/ Welcome  TLXY &/'p quote.txt



## 写入文件
	使用 > 文件重定向
	[root@localhost ~]# 
	[root@localhost ~]# sed '1,2 w file' quote.txt 
	The The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# cat fil
	file    filedt  filrft  
	[root@localhost ~]# cat file
	The The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	[root@localhost ~]# 




## 从文件中读取文本
	格式：
		address r  filename
	
	[root@localhost ~]# vim r.txt
	[root@localhost ~]# cat r.txt 
	I love my girl friend
	[root@localhost ~]# sed '/company/r r.txt' quote.txt 
	The The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	I love my girl friend
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	[root@localhost ~]# sed '$r r.txt' quote.txt 
	The The honeysuckle band played all night long for inly $90.
	It was an evening of splendid music and company.
	Too bad the disco floor fell through at 23:10.
	The local nurse MIss P.Neave was in attendance.
	I love my girl friend
	[root@localhost ~]# 



## 匹配后退出
	q
	有时候需要在模式匹配首次出现后退出，以便执行其他脚本指令
	格式：
		address q
	
	[root@localhost ~]# cat q.txt 
	Line 1.band
	Line 2.bad
	Line 3.was
	Line 4.was
	[root@localhost ~]#
	[root@localhost ~]# sed '/.*a.*/q' q.txt 
	Line 1.band
	[root@localhost ~]# 



## 去除首行数字
	
	[root@localhost ~]# cat a.txt 
	121Line 1.band
	3232Line 2.bad
	342345234Line 3.was
	342342Line 4.was
	[root@localhost ~]# 

	
	[root@localhost ~]# sed 's/^[0-9]*/Start /g' a.txt 
	Start Line 1.band
	Start Line 2.bad
	Start Line 3.was
	Start Line 4.was
	[root@localhost ~]# sed 's/^[0-9]*//g' a.txt 
	Line 1.band
	Line 2.bad
	Line 3.was
	Line 4.was
	[root@localhost ~]# 



## 处理报文数据
	[root@localhost ~]# cat sql.txt 
	Database	Size(MB)	Date Created
	…………………………………………………………………………
	GOSOUTH		2244		12/11/97
	TRISUD		5632		8/9/99
	(2 rows affected)
	[root@localhost ~]# 



	[root@localhost ~]# cat sql.txt | sed 's/……*//g' | sed '/^$/d' | sed '$d' | sed '1d' | awk '{print $0}'
	GOSOUTH		2244		12/11/97
	TRISUD		5632		8/9/99
	[root@localhost ~]# 
