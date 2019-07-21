# 反向输出输入的文本
s = input("请输入一短文本:")
i = len(s) - 1
while i >= 0:
    print(s[i], end="")
    i = i - 1
