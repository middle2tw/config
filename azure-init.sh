#!/bin/sh

# install apt
apt-get update -y
apt-get upgrade -y
apt-get install sudo pkg-config chkconfig rpm vim git tcsh make gcc g++ php5-curl php5-mysqlnd -y

# build deploy account
groupadd -g 888 code
useradd -u 888 -d /srv/code -r -g code code
mkdir -p ~code/.ssh/
curl -O ~code/.ssh/authorized_keys https://raw.githubusercontent.com/middle2tw/config/master/deploy-key
chown -R code:code ~code/

# change timezone
sh -c "echo Asia/Taipei > /etc/timezone"
cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# build admin account
useradd -u 1000 -d /home/srwang -r srwang
useradd -u 1001 -d /home/ctiml  -r ctiml
mkdir -p /home/srwang/.ssh
mkdir -p /home/ctiml/.ssh
chown -R srwang /home/srwang
chown -R ctiml /home/ctiml
echo "srwang ALL=(ALL) NOPASSWD: ALL\nctiml ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/middle2
curl -O ~srwang/.ssh/authorized_keys https://github.com/ronnywang.keys
curl -O ~ctiml/.ssh/authorized_keys https://github.com/ctiml.keys

