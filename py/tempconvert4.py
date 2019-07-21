########################################################################
# File Name: tempconvert4.py
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月11日 星期四 12时24分25秒
# Description:
#########################################################################
tempstr = input("请输入带有符号的温度值")
if tempstr[-1] in ['f', 'F']:
    c = eval(tempstr[0:-1])-32/1.8
    print("转换后的温度值")
elif tempstr[-1] in ['c', 'C']:
    F = 1.8*eval(tempstr[0:-1])+32
    print("转换后的温度值是{:.2f}F".format(F))
else:
    print("输入格式错误")
