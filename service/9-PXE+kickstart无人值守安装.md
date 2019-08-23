# PXE+kickstart实现无人值守安装
	- 高效的统一部署方式
	- 通过网络方式进行安装
	- 结合自动应答文件实现无人部署操作
	- 需要提前配置一台安装服务器



## 安装部署流程
	- 客户端需要现在BIOS中设置网络引导
	- 客户端启动后通过广播寻找DHCP服务器
	- 找到获取相应地址信息同时DHCP告诉客户端TFTP的位置
	- 从TFTP服务上下载启动文件到本地内存
	- 实现无盘启动

	- 在启动文件中设置kickstart文件共享位置，实现无人值守安装



## TFTP服务器
	简单文件共享服务
	小巧方便
	在此放置启动文件




## PXE
	
	- 网络引导
	- Inter公司  CS
	- 通过网络让客户端从远端服务器下载启动镜像，实现网络引导



## kickstart
	- kickstart目前主流的一种无人值守自动部署安装操作系统的方式
	- 核心文件叫做自动应答文件(kickstart文件)

	- kickstart文件三种生成方式
		- 手动书写
		- 通过system-config-kickstart图形工具
		- 通过红帽的安装程序anconda自动生成

	yum install system-config-kickstart -y





## 利用DHCP+TFTP+http搭建无人值守安装
	前提条件：
		关闭selinux
		关闭防火墙

			  110  systemctl stop firewalld.service 
			  111  systemctl disable firewalld.service 
			  112  setenforce 0


	##DHCP服务器
		yum install dhcp -y
		root@client ~]# cat  /etc/dhcp/dhcpd.conf 
		#
		# dhcpd.conf
		#
		# Sample configuration file for ISC dhcpd
		#
		
		# option definitions common to all supported networks...
		option domain-name "example.com";
		option domain-name-servers 192.168.0.20;
		
		default-lease-time 600;
		max-lease-time 7200;
		
		# This declaration allows BOOTP clients to get dynamic addresses,
		# which we don't really recommend.
		
		# A slightly different configuration for an internal subnet.
		subnet 192.168.0.0 netmask 255.255.255.0 {
		  range 192.168.0.100 192.168.0.110;
		  option domain-name-servers 192.168.0.20;
		  option domain-name "example.com";
		  option routers 192.168.0.254;
		  option broadcast-address 192.168.0.255;
		  default-lease-time 600;
		  max-lease-time 7200;
		  next-server 192.168.0.20;
		  filename "/pxelinux.0";
		}
		[root@client ~]# 


		  20  systemctl restart dhcpd
		  121  systemctl enable dhcpd
		  122  systemctl status dhcpd



	## 搭建TFTP服务器
		yum install tftp-server -y
		  125  vim /etc/xinetd.d/tftp 
		  126  systemctl restart xinetd.service 
		  127  systemctl enable xinetd.service



		default: off
		# description: The tftp server serves files using the trivial file transfer \
		#       protocol.  The tftp protocol is often used to boot diskless \
		#       workstations, download configuration files to network-aware printers, \
		#       and to start the installation process for some operating systems.
		service tftp
		{
		        socket_type             = dgram
		        protocol                = udp
		        wait                    = yes
		        user                    = root
		        server                  = /usr/sbin/in.tftpd
		        server_args             = -s /var/lib/tftpboot
		        disable                 = no
		        per_source              = 11
		        cps                     = 100 2
		        flags                   = IPv4
		}



	## 下载网络引导文件
		yum install syslinux -y

		#将pxelinux0复制到/var/lib/tftpboot/
		cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot/



		#创建/var/lib/tftpboot/pxelinmux.cfg
		mkdir /var/lib/tftpboot/pxelinux.cfg


		#将isolinux.cfg拷贝到高目录下并改名default
		[root@client ~]# cp -r /mnt/cdrom/isolinux/* /var/lib/tftpboot/
		[root@client ~]# cp /var/lib/tftpboot/isolinux.cfg /var/lib/tftpboot/pxelinux.cfg/default


	##安装http服务
		44  yum install httpd -y
	   146  systemctl restart httpd
	   147  systemctl enable httpd
	   148  mkdir /var/www/html/pub       ##存放光盘路径，光盘的挂载点
	   149  mkdir /var/www/html/ks        ##存放自动应答文件



	## 重新挂载光盘镜像到/var/www/html/pub
	 153  umount /mnt/cdrom/
 	 154  mount /dev/cdrom /var/www/html/pub/
 	 155  df -hT

		firefox http://192.168.0.20/pub



	##生成ks.cfg文件并拷贝至/var/www/html/ks/下
	yum install system-config-kickstart -y
	system-config-kickstart
	cp /root/ks.cfg /var/www/html/ks/ks.cfg


	## 编辑pxe网络引导菜单

		 cat /var/lib/tftpboot/pxelinux.cfg/default
		 label linux
 		 menu label ^Install RHEL 7 to pxe
		 kernel vmlinuz
 		 append initrd=initrd.img inst.stage2=http://192.168.0.20/pub ks=http://192.168.0.20/ks/ks.cfg





## rhel6安装
	mount /data/iso镜像文件  /mnt/cdrom
	cp /mnt/cdrom/isolinux/vmlinuz linird.img /var/lib/tftpboot/rhel6
	cat /var/lib/tftpboot/pxelinux.cfg/default
	 label linux
 	 menu label ^Install RHEL 6 to pxe
     kernel /rhel6/vmlinuz
     append initrd=/rhel6/initrd.img inst.stage2=http://192.168.0.20/rhel6
    menu separator # insert an empty line


	##安装源
		mkdir /var/www/html/rhel6
		mount /data/iso镜像文件  /var/www/html/rhel6 