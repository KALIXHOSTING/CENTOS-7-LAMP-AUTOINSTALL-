#!/bin/bash
###########################################################
#Script Auto Install Apache, PHP 7.4, MariaDB, phpmyadmin,FFMPEG,TRANSMISSION,OPENVPN,LETSENCRYPT
#Author		:  MAVEN
#Instagram	:  https://www.kalixhosting.com
#Version	:  1.0.0
#Date		:  02/08/2023
#OS		:  Centos 7
###########################################################

echo "Auto Install LAMP Centos 7"
echo "###########################"

#Update Centos
sudo setenforce 0
yum -y update
yum -y install wget
yum -y upgrade
yum install wget nano zip unzip -y
chmod +rw /root
chmod 777 /root
yum -y install epel-release

yum -y update


yum -y install transmission-cli transmission-common transmission-daemon

systemctl start transmission-daemon.service


#EPEL Repo
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh http://repo.mysql.com/mysql-community-release-el7-7.noarch.rpm
yum -y install yum-utils
yum --enablerepo=remi-php74 install php -y

#Install MariaDB
yum -y install mariadb-server mariadb
systemctl start mariadb.service
systemctl enable mariadb.service

#Install Apache
yum -y install httpd
systemctl start httpd.service
systemctl enable httpd.service

#FIREWALL PORTS HTTP AND HTTPS
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

#Install PHP 7.4
yum --enablerepo=remi-php74 install php74-php php74-php-pear php74-php-bcmath php74-php-pecl-jsond-devel php74-php-mysqlnd php74-php-gd php74-php-common php74-php-intl php74-php-cli php74-php php74-php-xml php74-php-opcache php74-php-pecl-apcu php74-php-pecl-jsond php74-php-pdo php74-php-gmp php74-php-process php74-php-pecl-imagick php74-php-devel php74-php-mbstring php74-php-soap php74-php-mcrypt php-mcrypt php-soap phpMyAdmin roundcubemail memcached php74-php-pecl-memcached php74-php-pecl-memcache php-opcache php-redis redis php74-php-redis php74-php-zip php74-php-pspell php-brotli -y

yum --enablerepo=epel,remi install httpd -y

systemctl restart httpd.service


echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php

#MariaDB Support PHP
sudo yum install mariadb-server -y
sudo systemctl start mysql.service
sudo systemctl enable mariadb
sudo systemctl start mariadb
systemctl restart httpd.service

#Install PHPMYADMIN
yum -y install phpMyAdmin

#CONFIG phpmyadmin
mv /etc/httpd/conf.d/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf.backup
wget https://raw.githubusercontent.com/KALIXHOSTING/lamp-centos-7-/main/phpMyAdmin.conf
cp phpMyAdmin.conf /etc/httpd/conf.d/

echo "Password Root MariaDB ? | Change MariaDB Root Password ? (y|n)"
read passmaria

case $passmaria in
	y | Y)
	mysql_secure_installation
	;;

	n | N)
	;;

	*)
	echo "Wrong Syntax :p"
	;;
esac
#RESTART APACHE
systemctl restart httpd.service


#CONFIG CERTBOT
sudo yum -y install certbot python2-certbot-apache mod_ssl

yum -y install perl-CGI perl-libwww-perl perl-DBI perl-DBD-MySQL perl-GD perl-Cache-Memcached perl-Digest-SHA perl-LWP-Protocol-https
#RESTART APACHE
systemctl restart httpd.service

#CHMOD VAR/WWW/HTML
chmod +rw /var
chmod +rw /var/www/html
chmod 777 /var
chmod 777 /var/www/html

#install FFMPEG
sudo yum install epel-release -y
sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm -y 
sudo yum install ffmpeg ffmpeg-devel -y

#install OPENVPN
wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh



echo "######## KALIXHOSTING AUTOINSTALL | FINISH #########"
