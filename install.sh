#! /bin/bash
echo 'UPDATE'

sudo yum clean all
echo 'done'


echo 'UPDATE'

sudo yum update -y

echo 'done'

echo 'UPGRADE'

sudo yum upgrade -y 

echo 'done'


echo 'INSTALL APACHE 2'

sudo yum install httpd -y


echo 'done'


echo 'START APACHE 2'

sudo systemctl start httpd.service

echo 'done'

echo 'MARIADB'

sudo yum install mariadb-server mariadb -y

echo 'done'

echo 'MARIADB start'

sudo systemctl start mariadb

echo 'done'

echo 'MARIADB ENABLE'

sudo yum install mariadb-server mariadb -y


echo 'done'

echo 'MARIADB LOGIN SET UP'

sudo mysql_secure_installation


echo 'done'



echo 'Mariadb SET UP'
sudo systemctl start mariadb

echo 'done'

echo 'php 7.4 ssl SET UP'
sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
echo 'done'

echo 'php7.4 SET UP'

sudo yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd -y


echo 'done'

echo 'RESTART APACHE SET UP'

sudo systemctl restart httpd.service


echo 'done'

echo 'PHP 7.4 SET UP'

sudo yum install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd


echo 'done'

echo 'FFMPEG SET UP'

sudo yum install epel-release -y


echo 'done'

echo 'FFMPEG SET UP'

sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm -y



echo 'done'

echo 'FFMPEG SET UP'

sudo yum install ffmpeg ffmpeg-devel -y 


echo 'done'

echo 'firewall'

sudo firewall-cmd --permanent --zone=public --add-service=http


echo 'done'

echo 'firewall'
sudo firewall-cmd --permanent --zone=public --add-service=https


echo 'done'


echo 'firewall'
sudo firewall-cmd --reload


echo 'done'

echo 'phpmyadmin'

sudo yum install phpmyadmin -y 

echo 'done'
