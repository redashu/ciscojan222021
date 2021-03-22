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

## Docker engine install on LInux 

[centos](https://docs.docker.com/engine/install/centos/)



# Docker operations 

## From client machine only 

### search 

```
10004  docker  search mongodb 
10005  docker  search  python
10006  history
10007  docker  search  dockerashu
10008  docker  search  ashutoshh

==

❯ docker search cisco
NAME                                    DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
ciscotestautomation/pyats               Cisco pyATS, an end-to-end testing ecosystem…   17                   
ciscocloud/mesos-consul                                                                 13                   [OK]
ciscocloud/haproxy-consul                                                               9                    [OK]
ciscocloud/marathon-consul                                                              7                    [OK]
ciscocloud/nginx-consul                                                                 6                    [OK]
jeffctor/cisco-lab                      A Docker image based GNS3 lab for Cisco IOS/…   3                    [OK]
ciscocloud/nginx-mantlui                                                                3                    
ciscosso/kdk                            Kubernetes Development Kit                      3                    [OK]
ciscosso/oauth2_proxy                   https://github.com/cisco-sso/oauth2_proxy       2                    [OK]
ciscocloud/logstash                                                                     2                    [OK]
ciscocloud/mantl                        mantl.io installer                              2                    [OK]
ciscocloud/mantl-api                                                                    1                    
ciscocsirt/srimonitor                                                                   0                    
ciscosso/atlantis                   


```

### operation flow

<img src="op.png">


### check docker images on docker engine 

```
❯ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED       SIZE
gcr.io/k8s-minikube/kicbase   v0.0.18   a776c544501a   3 weeks ago   1.08GB
❯ 

```


### download docker image from Docker hub 

```
❯ docker pull centos
Using default tag: latest
latest: Pulling from library/centos
7a0437f04f83: Pull complete 
Digest: sha256:5528e8b1b1719d34604c87e11dcd1c0a20bedf46e83b5632cdeac91b8c04efc1
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest
❯ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED        SIZE
gcr.io/k8s-minikube/kicbase   v0.0.18   a776c544501a   3 weeks ago    1.08GB
centos                        latest    300e315adb2f   3 months ago   209MB

==

10017  docker pull  busybox  
10018  docker pull  alpine 
❯ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED        SIZE
busybox                       latest    a9d583973f65   12 days ago    1.23MB
gcr.io/k8s-minikube/kicbase   v0.0.18   a776c544501a   3 weeks ago    1.08GB
alpine                        latest    28f6e2705743   4 weeks ago    5.61MB
centos                        latest    300e315adb2f   3 months ago   209MB


```

## on Docker engine server side image storage location 

```
[root@ip-172-31-76-202 sysconfig]# cd  /var/lib/docker/
[root@ip-172-31-76-202 docker]# ls
builder  buildkit  containers  image

```

## container need a program to run 

<img src="pp.png">

### First ever container 

```
❯ docker  run    alpine:latest  ping 127.0.0.1

PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=0 ttl=64 time=0.269 ms
64 bytes from 127.0.0.1: seq=1 ttl=64 time=0.077 ms
64 bytes from 127.0.0.1: seq=2 ttl=64 time=0.150 ms
64 bytes from 127.0.0.1: seq=3 ttl=64 time=0.271 ms
64 bytes from 127.0.0.1: seq=4 ttl=64 time=0.161 ms
64 bytes from 127.0.0.1: seq=5 ttl=64 time=0.080 ms
64 bytes from 127.0.0.1: seq=6 ttl=64 time=0.178 ms
^C64 bytes from 127.0.0.1: seq=7 ttl=64 time=0.102 ms

--- 127.0.0.1 ping statistics ---
8 packets transmitted, 8 packets received, 0% packet loss
round-trip min/avg/max = 0.077/0.161/0.271 ms

```

## best practise to create contianer

```
❯ docker  run  -d  --name  ashuc1  alpine:latest  ping 127.0.0.1
3f16bc4ecfdfedb538d293cb93bfadcd3867b6e824aaa8935635f244c9e3b55d
❯ docker  ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED         STATUS         PORTS                                                                                                                                  NAMES
3f16bc4ecfdf   alpine:latest                         "ping 127.0.0.1"         5 seconds ago   Up 3 seconds                                                                                                                                          ashuc1

```


## Container createion 

<img src="cc.png">

### to check only running container 

```
❯ docker  ps
CONTAINER ID   IMAGE           COMMAND            CREATED         STATUS         PORTS     NAMES
3f16bc4ecfdf   alpine:latest   "ping 127.0.0.1"   7 minutes ago   Up 7 minutes             ashuc1


```

### to check output of process running inside container 

```
❯ docker  logs   ashuc1
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=0 ttl=64 time=11.879 ms
64 bytes from 127.0.0.1: seq=1 ttl=64 time=0.090 ms
64 bytes from 127.0.0.1: seq=2 ttl=64 time=0.094 ms
64 bytes from 127.0.0.1: seq=3 ttl=64 time=0.133 ms
64 bytes from 127.0.0.1: seq=4 ttl=64 time=0.448 ms
64 bytes from 127.0.0.1: seq=5 ttl=64 time=1.845 ms
64 bytes from 127.0.0.1: seq=6 ttl=64 time=0.093 ms

```

## start a stopped container 

```
❯ docker  start  ashuc1
ashuc1
❯ docker  ps
CONTAINER ID   IMAGE           COMMAND            CREATED         STATUS         PORTS     NAMES
3f16bc4ecfdf   alpine:latest   "ping 127.0.0.1"   9 minutes ago   Up 4 seconds             ashuc1

```

### more operations on docker 

```
10023  docker  run    alpine:latest  ping 127.0.0.1 
10024  docker  ps  
10025  docker  ps  -a
10026  history
10027  docker  run  -d  --name  ashuc1  alpine:latest  ping 127.0.0.1
10028  docker  ps
10029  history
10030  docker  ps
10031* minikube stop 
10032  docker  ps
10033  docker  logs   ashuc1 
10034  history
10035  docker  ps
10036  docker  stop ashuc1
10037  docker  ps
10038  docker  ps -a
10039  docker  start  ashuc1
10040  docker  ps
10041  docker kill ashuc1
10042  docker  start  ashuc1
10043  docker  ps

```

