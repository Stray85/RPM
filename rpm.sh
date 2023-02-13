#!/bin/bash
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc nano
wget -P /root https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm 
rpm -i /root/nginx-1.20.2-1.el8.ngx.src.rpm 
wget --no-check-certificate -P /root https://www.openssl.org/source/openssl-1.1.1t.tar.gz
tar -xvf /root/openssl-1.1.1t.tar.gz
yum-builddep -y /root/rpmbuild/SPECS/nginx.spec
rpmbuild -bb rpmbuild/SPECS/nginx.spec
yum localinstall -y \rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el7.ngx.x86_64.rpm
systemctl start nginx

mkdir /usr/share/nginx/html/repo
cp /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el7.ngx.x86_64.rpm
wget https://downloads.percona.com/downloads/percona-distribution-mysql-ps/perconadistribution-mysql-ps-8.0.28/binary/redhat/8/x86_64/perconaorchestrator-3.2.6-2.el8.x86_64.rpm -O /usr/share/nginx/html/repo/perconaorchestrator-3.2.6-2.el8.x86_64.rpm

createrepo /usr/share/nginx/html/repo/

cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
