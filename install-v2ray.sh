#!/bin/bash
#网络不应该被审查;
#信息不应该被封锁;
#信息不应该被收费;
#人人自由且平等;
#You are not Alone;
#-------Color_Code;---------;
grey="\033[1;37m"
purple="\033[1;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
cyan="\033[1;36m"
blue="\033[1;34m"
c="\e[0m"
#-------V2ray_logo;---------;
V2ray_logo ()
{
	echo -e $green '
	 m    m  mmmm               m     m
	 "m  m" "   "#  m mm   mmm   "m m" 
	  #  #      m"  #"  " "   #   "#"  
	  "mm"    m"    #     m"""#    #   
	   ##   m#mmmm  #     "mm"#    #	
	' $c
}
#-------Error_logo;---------;
Error_logo ()
{
	echo -e $red '
	 mmmmmm                            
	 #       m mm   m mm   mmm    m mm 
	 #mmmmm  #"  "  #"  " #" "#   #"  "
	 #       #      #     #   #   #    
	 #mmmmm  #      #     "#m#"   #
	' $c
}
#-----------PATH;-----------;
dir="`pwd`/Allsh/Server"
#-------Root权限检测;-------;
Root ()
{
	[ `id -u` != 0 ] && Error_logo && 
		sleep 2 ; echo -e $red '请使用root权限执行此脚本;' $c &&
		sleep 1 ; exit 0
}
#-------发行版检测;---------;x
Fxbjc ()
{
	#Ubuntu;
	if grep -Eq 'Ubuntu' /etc/*-release; then
		echo -e $green '您的发行版:Ubuntu' $c
	elif grep -Eq 'Ubuntu' /etc/*-release ; then
		echo -e $green '您的发行版:Debian' $c
	elif grep -Eq 'CentOS' /etc/*-release; then
		echo -e $green '您的发行版:CentOS' $c
	else
		echo -e $red '抱歉,您的发行版不在此脚本支持范围内,你懂我的意思;'
		sleep 2 && Error && exit 0
	fi
}
#---V2ray_install-Server;---;
V2ray_install ()
{
	mv V2ray/v2ray/ /usr/bin/ > /dev/null		#主程序;
	mv V2ray/v2ray.service /lib/systemd/system/ > /dev/null		#v2ray系统服务;
	mkdir -p /etc/v2ray 	#配置文件;
	systemctl daemon-reload && systemctl enable v2ray.service	#设置v2ray为系统服务;
}
#------Service_config;------;
Service_config ()
{
	echo -e $red '使用默认配置,请选0;使用自定义的配置请选1;' $c
	read -p "请输入:" input
	case "$input" in
		"0")
			
			;;
		"1")
			echo -e $red '你必须清楚您的这些设置意味什么,否则请使用默认的配置;' $c 
			echo -e $red '由于GFW已经升级,So一些不耐操的配置不将纳入此脚本;
			建议您至少使用WebSocket+Tls+Caddy;或者使用更安全的WebSocket+Tls+Web+CDN' $c
			sleep 2
			clear
			echo -e $green '请选择传输模式' $c
			echo -e $green '<--0-->使用WebSocket+Tls+Web+Caddy;' $c
			echo -e $green '<--1-->使用WebSocket+Tls+Web+CDN;' $c
			echo -e $green '<--2-->使用WebSocket+Tls+Web;' $c
			echo -e $green '<--3-->使用Kcp+动态端口;' $c
			echo -e $green '<--4-->使用Kcp+流量伪装;' $c
			read -p "请输入:" input
			case "$input" in
				"0")
					xy='WebSocket+Tls+Web+Caddy'
					echo $green '请输入主端口:' $c
					read port
					echo $green '请输入域名务必正确:' $c
					read yname
					#[ `ifconfig | grep inet | sed  -n 1p | awk '{print $2}'` == $yname ] && echo 1 || echo 2
					#ping -c 4 $yname && echo '' || echo -e $red '错误的域名' $c ; sleep 2 && Error ; exit 0
					#检测域名是否解析正确;
					if [ `ping -nc 3 free2aa.tk | sed -n 1p | awk '{print $3}' | cut -d \( -f 2 | cut -d \) -f 1` == `ifconfig | grep inet | sed  -n 1p | awk '{print $2}'` ]; then
						echo $green 'Good域名解析正确!'	$c
						clear 
						echo -e $green '这是您的配置' $c
						echo -e $green "传输协议:$xy" $c
						echo -e $green "V2ray主端口:$port" $c
						echo -e $green "您的域名:$yname" $c
						sleep 2
						. $dir/W+T+W.sh
					else
						echo -e $red 'Sorry,域名解析错误;'
						sleep 2
						Error
						exit 0
					fi
					;;
				"1")
					;;
				"2")
					;;
				"3")
					xy='Kcp+动态端口'
					echo -e $green '' $c
					;;
				"4")
					xy='Kcp+流量伪装'
					;;
				*)
					echo -e $red '输入错误,请瞅准您的键盘;' $c
					;;

			esac
			;;
		*)
			echo -e $red '输入错误,请瞅准您的键盘;' $c
			Error
			sleep 2
			clear ; exit 0
			;;
	esac
}
#----------Caddy;-----------;
Caddy_install ()
{
	
}
#----基于服务端配置的修改---;
XG_config ()
{
	
}
#----------main;------------;
main ()
{
	Root 
	Fxbjc
	V2ray_logo
	Error_logo
}
main
	#cat /etc/*-release | sed -n 1p | cut -d= -f 2 | grep 'Ubuntu'	#发行版获取;
	#cat /etc/*-release | sed -n 3p | cut -d= -f 2					#发行版代号;
