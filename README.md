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

