#!/bin/bash
yum -y update
yum -y install httpd
echo "<html lang="en" dir="ltr"><head><meta charset="utf-8"><title>Hello World</title></head><body></body></html>>" > /var/www/html/index.html
systemctl enable httpd
systemctl start httpd
ll /home/ec2-user
