#########################################################################
# File Name: nmap.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月17日 星期三 10时44分47秒
# Description: cmd 为ping扫描方式   cmd2为TCP扫描方式 
#########################################################################
#!/bin/bash
cmd="nmap -sP"
ip="192.168.122.1/24"
cmd2="nmap -sS"
sudo $cmd $ip | awk '/Nmap scan report for/{print $NF "  is ok"}'
