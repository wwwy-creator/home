# 反向输出输入的文本，采用反向序列的方法
s = input("请输入一短文本:")
i = -1
while i >= -len(s):
    print(s[i], end="")
    i = i-1
