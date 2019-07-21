########################################################################
# File Name: pythondraw.py
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月11日 星期四 16时48分40秒
# Description:
#########################################################################
import turtle
turtle.setup(650, 350, 200, 200)
turtle.penup()
turtle.fd(-250)
turtle.pendown()
turtle.pensize(25)
turtle.pencolor("red")
turtle.seth(-40)
for i in range(4):
    turtle.circle(40, 80)
    turtle.circle(-40, 80)
turtle.circle(40, 80/2)
turtle.fd(40)
turtle.circle(16, 180)
turtle.fd(40 * 2/3)
turtle.done()
