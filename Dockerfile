FROM centos:centos8.3.2011
MAINTAINER cosmos <cosmos041389@gmail.com>

ARG DIR=/root/workload-kkc
ARG SRC=/root/workload-kkc/sources
ENV TMP=/root/workload-kkc/temp

RUN 	sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*; \
	sed -i 's/#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/g' /etc/yum.repos.d/CentOS-Linux-*; \
	dnf install -y git make gcc gcc-c++ numactl-devel numactl-libs numad wget time python2 python3 ant zlib zlib-devel; \
	yum install -y yum-utils; \
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo; \
	yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; \
	mkdir /root/workload-kkc; \
	mkdir /root/workload-kkc/datasets; \
	mkdir /root/workload-kkc/evaluation; \
	mkdir /root/workload-kkc/scripts2; \
	mkdir /root/workload-kkc/sources;

WORKDIR /root/workload-kkc/scripts2
