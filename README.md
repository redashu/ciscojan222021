# Container Isolation 

## Namespaces 

<img src="ns.png">

## Cgroups to put the limit on resources for each container 

<img src="cgroups.png">


# Cgroups demo 

## creating container 

```
❯ docker  run -itd --name ashux1 alpine ping 127.0.0.1
cf48901093b8a1af44987b1ad6bb96f30bcb6a1505c17d4d188d58ca8cfb57cb
❯ docker  ps
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS     NAMES
cf48901093b8   alpine    "ping 127.0.0.1"   6 seconds ago   Up 3 seconds             ashux1

```

## checking current resources 

```
> docker stats ashux1 
> 
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT   MEM %     NET I/O      BLOCK I/O   PIDS
cf48901093b8   ashux1    0.01%     608KiB / 7.69GiB    0.01%     1.2kB / 0B   0B / 0B     1

```

### creating container with limited resources 

```
❯ docker  run -itd --name ashux2  --memory 100m --cpu-shares=20  alpine ping 127.0.0.1
679c4c18e18c7bd2d3dab40674431abaac8cfd9451aaaa3467db1950d3e8dc56

==
checking stats 

docker stats 

CONTAINER ID   NAME         CPU %     MEM USAGE / LIMIT    MEM %     NET I/O           BLOCK I/O   PIDS
679c4c18e18c   ashux2       0.01%     628KiB / 100MiB      0.61%     726B / 0B         0B / 0B     1
70f414e6437a   murali36x1   0.03%     748KiB / 7.69GiB     0.01%     14.9kB / 13.8kB   0B / 0B     2

```

## restart policy 

```
 docker  run -itd --name ashux2  --memory 100m --cpu-shares=20  --restart always alpine ping 127.0.0.1 

❯ docker  inspect  ashux3  -f '{{.HostConfig.RestartPolicy}}'
{always 0}
❯ docker  inspect  ashux3  -f '{{.HostConfig.RestartPolicy.Name}}'
always
❯ docker  inspect  ashux1  -f '{{.HostConfig.RestartPolicy.Name}}'
no

```

## Containerization of python Flask web application 

### Clone git code 

```
❯ git clone  https://github.com/redashu/flaskapp
Cloning into 'flaskapp'...
remote: Enumerating objects: 20, done.
remote: Counting objects: 100% (20/20), done.
remote: Compressing objects: 100% (14/14), done.
remote: Total 20 (delta 6), reused 9 (delta 2), pack-reused 0
Unpacking objects: 100% (20/20), 2.99 KiB | 76.00 KiB/s, done.
❯ ls
flaskapp   

```

### Create Dockerfile 

```
cat ashu.dockerfile

FROM ubuntu
MAINTAINER  ashutoshh@linux.com
RUN apt update
RUN apt install python3 -y
RUN     apt install python3-pip -y 
# to install flask we need pip3 command 
RUN mkdir /webapp
# here i am creating a folder to store my Flask application 
COPY  . /webapp/
WORKDIR /webapp
# changing directory 
RUN pip3 install -r requirements.txt
# install python Flask framework 
EXPOSE 5000
# is optional part but you set some default port with container IP 
CMD ["python3","demo.py"]

```

### building docker image for flask

```
docker  build  -t  ashuflask:v001  -f  ashu.dockerfile  .

```

## few more discussion on docker build 

```
10090  docker  build -t  ashuflask:v001  -f  ashu.dockerfile  .
10091  docker  history  ashuflask:v001
10092  ls
10093  docker  build -t  ashuflask:v002  -f  test.dockerfile  .
10094  history
10095  docker  build -t  ashuflask:v003  -f  test.dockerfile  .
10096  docker  inspect  ashuflask:v003  
10097  docker  inspect  ashuflask:v003    |   grep -i ashu
10098  history
10099  docker  images
10100  history
10101  docker history  ashuflask:v003
10102  docker history  ubuntu
10103  history
10104  docker history  ashuflask:v001
10105  docker  tag  5494070a8c2e   common:flasklayer

```


