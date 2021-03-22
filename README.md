# Docker pre discussions 

## application deployment problems with Bare-metal 

<img src="bare.png">


## application deployment with Virtualization technology 

<img src="vm.png">

## Application doesn't require entire OS 

<img src="os.png">

## welcome to containers 

### VM vs containers 

<img src="cont.png">

## Container support in host kernel

<img src="hostk.png">

## container runtime engines  [CRE]

<img src="cre.png">

## Docker based containers 

<img src="docker-ce.png">

## Docker Desktop for mac 

[mac Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-mac)

## Docker desktop for windows 10 

[w10docker desktop](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)



## Connecting docker engine from Client machine 

```
❯ docker  version
Client: Docker Engine - Community
 Cloud integration: 1.0.9
 Version:           20.10.5
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        55c4c88
 Built:             Tue Mar  2 20:13:00 2021
 OS/Arch:           darwin/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.2
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       8891c58
  Built:            Mon Dec 28 16:15:28 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.3
  GitCommit:        269548fa27e0089a8b8278fc4fc781d7f65a939b
 runc:
  Version:          1.0.0-rc92
  GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

```

## Docker arch 

<img src="darch.png">

## Installing docker engine on LInux machine without docker desktop 

```
[root@ip-172-31-76-202 ~]# history 
    1  docker  version 
    2  yum  install  docker  -y
    3  history 
[root@ip-172-31-76-202 ~]# cd  /etc/sysconfig/
[root@ip-172-31-76-202 sysconfig]# ls
acpid       console         grub        man-db           nfs            rpcbind    sshd
atd         cpupower        i18n        modules          raid-check     rsyncd     sysstat
authconfig  crond           init        netconsole       rdisc          rsyslog    sysstat.ioconf
chronyd     docker          irqbalance  network          readonly-root  run-parts
clock       docker-storage  keyboard    network-scripts  rpc-rquotad    selinux
[root@ip-172-31-76-202 sysconfig]# vim  docker
[root@ip-172-31-76-202 sysconfig]# systemctl daemon-reload 
[root@ip-172-31-76-202 sysconfig]# systemctl restart docker 

```

