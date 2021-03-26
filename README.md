# k8s application deployment best practise 

## Single YAML file can hold all the information like NS, Deployment , SErvices

## Deployment demo best practise 

```
10008  kubectl  create  namespace  customer1ns  --dry-run=client -o yaml  >testapp.yml
10009  kubectl  create deployment  dep123 --image=dockerashu/ciscong:v2  --dry-run=client -o yaml  >>testapp.yml
10010  kubectl  create service  nodeport  ashuxvc1  --tcp 1234:80  --dry-run=client -o yaml  >>testapp.yml
10011  kubectl  apply -f  testapp.yml
10012  kubectl   get  all  -n  customer1ns 

░▒▓ ~/Desktop/mydockerimages/k8sapps ··························· kubernetes-admin@kubernetes/ashux ⎈  09:28:03 AM ▓▒░─╮
❯ kubectl   get  all  -n  customer1ns                                                                                   ─╯
❯ kubectl   get  all  -n  customer1ns
NAME                         READY   STATUS    RESTARTS   AGE
pod/dep123-b76475c7b-bmt5p   1/1     Running   0          9m1s

NAME               TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/ashuxvc1   NodePort   10.100.219.120   <none>        1234:31690/TCP   9m1s

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/dep123   1/1     1            1           9m2s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/dep123-b76475c7b   1         1         1       9m3s
❯ kubectl delete -f  testapp.yml
namespace "customer1ns" deleted
deployment.apps "dep123" deleted
service "ashuxvc1" deleted


```

## Deployment with private registry 

<img src="priv.png">

```
kubectl  create  deployment  ashudep22  --image=ciscoindia.azurecr.io/webapp:v1  --dry-run=client -o yaml >privdep.yml
```

### deploying 

```
❯ kubectl   apply -f  privdep.yml
deployment.apps/ashudep22 created
❯ kubectl   get  deploy
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
ashudep22   0/1     1            0           10s
❯ kubectl   get  po
NAME                         READY   STATUS             RESTARTS   AGE
ashudep22-78d86565f6-wn7gm   0/1     ImagePullBackOff   0          27s

```

## Secret in k8s

<img src="secret.png">

### create secret to store docker registry credential 

```
kubectl  create  secret  docker-registry  ashusec1  --docker-server=ciscoindia.azurecr.io  --docker-username=ciscoindia    --docker-password=DGSQbiwgRYr  -n ashux
secret/ashusec1 created

```
## delete secret 

```
❯ kubectl delete all --all
pod "ashudep22-5975f5f895-6cqjv" deleted
deployment.apps "ashudep22" deleted
❯ kubectl  get  secret
NAME                  TYPE                                  DATA   AGE
ashusec1              kubernetes.io/dockerconfigjson        1      11m
default-token-8hg75   kubernetes.io/service-account-token   3      19h
❯ kubectl  delete secret  ashusec1
secret "ashusec1" deleted

```

# Storage in k8s

<img src="st.png">

## Volume in k8s

<img src="vol.png">

## deployment of pod with Emptydir volume type 

```
❯ kubectl  apply -f  emptyvolpod.yml
pod/ashupod1 created
❯ kubectl   get  po
NAME       READY   STATUS    RESTARTS   AGE
ashupod1   1/1     Running   0          5s

```

### checking data 

```
❯ kubectl  exec -it  ashupod1 -- sh
/ # cd  /mnt/
/mnt # ls
cisco
/mnt # cd  cisco/
/mnt/cisco # ls
time.txt
/mnt/cisco # cat  time.txt 
Fri Mar 26 05:07:42 UTC 2021
Fri Mar 26 05:07:47 UTC 2021
Fri Mar 26 05:07:52 UTC 2021
Fri Mar 26 05:07:57 UTC 2021
Fri Mar 26 05:08:02 UTC 2021
Fri Mar 26 05:08:07 UTC 2021
Fri Mar 26 05:08:12 UTC 2021
Fri Mar 26 05:08:17 UTC 2021
Fri Mar 26 05:08:22 UTC 2021
Fri Mar 26 05:08:27 UTC 2021
Fri Mar 26 05:08:32 UTC 2021
/mnt/cisco # 

```

## multi container POd 

```
❯ kubectl  apply -f  emptyvolpod.yml
pod/ashupod1 created
❯ kubectl  get  pods
NAME       READY   STATUS    RESTARTS   AGE
ashupod1   2/2     Running   0          5s
❯ kubectl  exec  -it  ashupod1  -c  ashucc1  -- bash
root@ashupod1:/# cd /usr/share/nginx/html/
root@ashupod1:/usr/share/nginx/html# ls
time.txt
root@ashupod1:/usr/share/nginx/html# exit
❯ kubectl  exec  -it  ashupod1  -c  ashupod1  -- sh
/ # 
/ # 
/ # cd /mnt/cisco/
/mnt/cisco # ls
time.txt
/mnt/cisco # 

```

## creating service and access data 

```
❯ kubectl  expose pod  ashupod1  --type NodePort --port 1234 --target-port 80 --name x1svc1
service/x1svc1 exposed
❯ kubectl  get  svc
NAME     TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
x1svc1   NodePort   10.101.187.162   <none>        1234:31401/TCP   3s

```




