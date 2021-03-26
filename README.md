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

## Hostpath volume type 

```
❯ kubectl apply -f  hostpath1.yml
pod/ashupod1 created
❯ kubectl  get  po
NAME       READY   STATUS    RESTARTS   AGE
ashupod1   1/1     Running   0          5s
❯ kubectl  exec -it  ashupod1 -- sh
/ # cd /mnt/cisco/
/mnt/cisco # ls
DIR_COLORS               exports                  mke2fs.conf              rsyslog.d
DIR_COLORS.256color      exports.d                modprobe.d               rwtab
DIR_COLORS.lightbgcolor  filesystems              modules-load.d           rwtab.d
GREP_COLORS              fstab                    motd                     sasl2
GeoIP.conf               gcrypt                   mtab                     scl
GeoIP.conf.default       gnu

```

# Microservice sample example 

## creating things for Mysql Db 

### creating secret 

```
kubectl  create  secret    generic  dbsec   --from-literal  pw=Ciscodb098  --dry-run=client -o yaml  >microservice.yml

```

### creating db deployment 

```
kubectl  create  deployment  ashudb  --image=mysql:5.6  --dry-run=client -o yaml  >>microservice.yml
```

### creating db service 

```
kubectl  create  service  clusterip  ashudbsvc --tcp 3306  --dry-run=client -o yaml  >>microservice.yml

```

### deployment of database deployment 

```
❯ kubectl  apply -f  microservice.yml
secret/dbsec created
deployment.apps/ashudb created
service/ashudbsvc created
❯ kubectl  get  secret
NAME                  TYPE                                  DATA   AGE
dbsec                 Opaque                                1      14s
default-token-8hg75   kubernetes.io/service-account-token   3      21h
❯ kubectl  get  deploy
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
ashudb   1/1     1            1           21s
❯ kubectl  get  svc
NAME        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
ashudbsvc   ClusterIP   10.110.37.230   <none>        3306/TCP   26s
```
### creating deployment for webapplication 

```
kubectl  create deployment  ashwebapp  --image=wordpress:4.8-apache  --dry-run=client -o yaml >>microservice.yml

```

### creating nodeport service for web app

```
 kubectl  create  service  nodeport  ashuwebsvc  --tcp 1234:80  --dry-run=client -o yaml >>microservice.yml
 
```

### microservice example 

<img src="mc.png">

## final deployment 

```
❯ kubectl  apply -f  microservice.yml --dry-run=client
secret/dbsec configured (dry run)
deployment.apps/ashudb configured (dry run)
service/ashudbsvc configured (dry run)
deployment.apps/ashwebapp created (dry run)
service/ashuwebsvc created (dry run)
❯ kubectl  apply -f  microservice.yml
secret/dbsec configured
deployment.apps/ashudb configured
service/ashudbsvc configured
deployment.apps/ashwebapp created
service/ashuwebsvc created
❯ kubectl  get deploy
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
ashudb      1/1     1            1           19m
ashwebapp   1/1     1            1           19s
❯ kubectl  get  svc
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
ashudbsvc    ClusterIP   10.110.37.230    <none>        3306/TCP         19m
ashuwebsvc   NodePort    10.111.238.173   <none>        1234:31549/TCP   28s
❯ kubectl  get  po
NAME                         READY   STATUS    RESTARTS   AGE
ashudb-8448dccc7f-mhj9m      1/1     Running   0          19m
ashwebapp-5c68869c5b-snqkk   1/1     Running   0          35s

```

## wordpress microservices history 

```
10089  kubectl  create  secret    generic  dbsec   --from-literal  pw=Ciscodb098  --dry-run=client -o yaml 
10090  kubectl  create  secret    generic  dbsec   --from-literal  pw=Ciscodb098  --dry-run=client -o yaml  >microservice.yml
10091  cat  microservice.yml
10092  history
10093  kubectl  create  deployment  ashudb  --image=mysql:5.6  --dry-run=client -o yaml  >>microservice.yml
10094  ls
10095  kubectl  apply -f  microservice.yml --dry-run=client  
10096  kubectl  get  deploy 
10097  history
10098  kubectl  apply -f  microservice.yml --dry-run=client  
10099  kubectl  create  service  clusterip  ashudbsvc --tcp 3306  --dry-run=client -o yaml 
10100  kubectl  create  service  clusterip  ashudbsvc --tcp 3306  --dry-run=client -o yaml  >>microservice.yml
10101  ls
10102  kubectl  config get-contexts  
10103  kubectl  apply -f  microservice.yml
10104  kubectl  get  secret
10105  kubectl  get  deploy
10106  kubectl  get  svc
10107  kubectl  get  po
10108  kubectl  logs  -f  ashudb-8448dccc7f-mhj9m 
10109  history
10110  kubectl  get  po
10111  kubectl  get  deploy
10112  history
10113  kubectl  create deployment  ashwebapp  --image=wordpress:4.8-apache  --dry-run=client -o yaml >>microservice.yml
10114  kubectl  get  svc
10115  kubectl  create  service  nodeport  ashuwebsvc  --tcp 1234:80  --dry-run=client -o yaml >>microservice.yml
10116  kubectl  apply -f  microservice.yml --dry-run=client  
10117  kubectl  apply -f  microservice.yml 
10118  kubectl  get deploy 
10119  kubectl  get  svc
10120  kubectl  get  po

```

# Dashboard in k8s

<img src="dboard.png">

## to create dashboard we need -- users & roles understanding 

### users 

<img src="user.png">


## svc account 

### every namespace has service account and their password got stored in secret 

```
❯ kubectl  get  sa
NAME      SECRETS   AGE
default   1         23h
❯ kubectl  get  secret
NAME                  TYPE                                  DATA   AGE
dbsec                 Opaque                                1      148m
default-token-8hg75   kubernetes.io/service-account-token   3      23h
❯ kubectl  describe secret  default-token-8hg75
Name:         default-token-8hg75
Namespace:    ashux
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 393d06fb-178a-4621-b6a8-9a9ca54a5015

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1066 bytes
namespace:  5 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6Indfd2YwTGpGdUxQb2g1cE91QnB1NHJ3NmVUR0tqM1BoT1FnN1Z1Smpqa0kifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJhc2h1eCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkZWZhdWx0LXRva2VuLThoZzc1Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImRlZmF1bHQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIzOTNkMDZmYi0xNzhhLTQ2MjEtYjZhOC05YTljYTU0YTUwMTUiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6YXNodXg6ZGVmYXVsdCJ9.isG1ay8CCyuaUg5nQJcNKZZ6-ZGJCivQSoWRjTgWLaAeV8htJ1do1haXYuo0m9jxWZx2IhV5C2NVSKx2fWTLbjC_kBw0E_LTLTatfQO7ME95LUTEAWlKPah11GZyivrXLDmMEPy4B3_ywm0NkVNmaMZgD3QGitDaA7aCKdDjXgNrZbqqAAng7DUwxnvFTZ-HCK_mXPbE3QbwryaFyu7nvyR2V6c3uRVSo36dVGrmYD-FYS4F_4uji2yBl-DveL0KIzcduDg_j3s8NZdH2B_1QkBQVB-aHTwV-ICW-TrQ8Bz4Tk5QSM-9jYfLR2TRPhEefGn_Awis60KXFdnmQJhkZQ


```


## deploying dashboard 

```
 kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
namespace/kubernetes-dashboard created
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scraper created

```

## contexts in k8s 

```
❯ kubectl  config get-contexts
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   ashux
❯ kubectl  config get-contexts
CURRENT   NAME                                                   CLUSTER                                                AUTHINFO                                               NAMESPACE
*         arn:aws:eks:us-east-1:061112302981:cluster/ciscoclss   arn:aws:eks:us-east-1:061112302981:cluster/ciscoclss   arn:aws:eks:us-east-1:061112302981:cluster/ciscoclss   
          kubernetes-admin@kubernetes                            kubernetes                                             kubernetes-admin                                       ashux
❯ 
❯ kubectl  get  nodes
NAME                            STATUS   ROLES    AGE   VERSION
ip-172-31-25-66.ec2.internal    Ready    <none>   25m   v1.18.9-eks-d1db3c
ip-172-31-85-147.ec2.internal   Ready    <none>   25m   v1.18.9-eks-d1db3c
❯ kubectl   config  set-context  kubernetes-admin@kubernetes
Context "kubernetes-admin@kubernetes" modified.
❯ kubectl  get  nodes
NAME                            STATUS   ROLES    AGE   VERSION
ip-172-31-25-66.ec2.internal    Ready    <none>   26m   v1.18.9-eks-d1db3c
ip-172-31-85-147.ec2.internal   Ready    <none>   26m   v1.18.9-eks-d1db3c
❯ kubectl   config  use-context  kubernetes-admin@kubernetes
Switched to context "kubernetes-admin@kubernetes".
❯ kubectl  get  nodes
NAME            STATUS   ROLES                  AGE   VERSION
master-node     Ready    control-plane,master   47h   v1.20.5
minion-node-1   Ready    <none>                 47h   v1.20.5
minion-node-2   Ready    <none>                 47h   v1.20.5
minion-node-3   Ready    <none>                 47h   v1.20.5

```




