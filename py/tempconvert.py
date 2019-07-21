########################################################################
# File Name: tempconvert.py
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月10日 星期三 20时16分57秒
# Description:
#########################################################################
tempstr = input("请输入带有符号的温度值例如：25c")
if tempstr[-1] in ['f', 'F']:
    c = (eval(tempsrt[0:-1])-32)/1.8
print("转换后的温度是{:.2f}c".format(c))

elif tempstr[-1] in ['c', 'C']:
    f = 1.8*eval(tempstr[0:-1])+32
print("转换后的温度是{:.2f}F".format(f))
else:
    print("输入格式错误")
