# Application deployment in k8s 

## Web application (multiweb)

### Docker based containerization 

<img src="appdep.png">

## Passing env variable in Docker container creation time 

```
docker  run -itd --name xx1  -p 1133:80  -e x=website1  dockerashu/ciscoweb:march2021v1 

```
## Generate YAML file automatically 

### if kubectl version --client is lower than 1.18 

```
kubectl  run  ashuwebpod  --image=dockerashu/ciscoweb:march2021v1 --port=80  --restart=Never  --dry-run -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashuwebpod
  name: ashuwebpod
spec:
  containers:
  - image: dockerashu/ciscoweb:march2021v1
    name: ashuwebpod
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}

```

### if kubectl version is 1.18 or higher 

```
❯ kubectl  run  ashuwebpod  --image=dockerashu/ciscoweb:march2021v1 --port=80    --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: ashuwebpod
  name: ashuwebpod
spec:
  containers:
  - image: dockerashu/ciscoweb:march2021v1
    name: ashuwebpod
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```

### creating yaml and storing in a file

```
kubectl  run  ashuwebpod  --image=dockerashu/ciscoweb:march2021v1 --port=80    --dry-run=client -o yaml  >webpod.yml

```

## deploy pod 

```
❯ ls
ashupod1.yaml webpod.yml
❯ kubectl  apply -f  webpod.yml
pod/ashuwebpod created
❯ kubectl  get  pods
NAME         READY   STATUS    RESTARTS   AGE
ashuwebpod   1/1     Running   0          13s
❯ kubectl  get  pods -o wide
NAME         READY   STATUS    RESTARTS   AGE   IP                NODE            NOMINATED NODE   READINESS GATES
ashuwebpod   1/1     Running   0          20s   192.168.174.201   minion-node-3   <none>           <none>


```

## Accesing application in the POd 

<img src="net.png">


## Need of service  in k8s 

<img src="serviceud.png">

## service type 

<img src="stype.png">

## how service will find the pod 

### service will use label of POD to find 

<img src="slabel.png">

## everything you need to remember about servie 

<img src="service.png">

## final service diagram

<img src="sfinal.png">

## checking label 

```
❯ kubectl  get  po  ashuwebpod
NAME         READY   STATUS    RESTARTS   AGE
ashuwebpod   1/1     Running   0          95m
❯ kubectl  get  po  ashuwebpod  --show-labels
NAME         READY   STATUS    RESTARTS   AGE   LABELS
ashuwebpod   1/1     Running   0          95m   run=ashuwebpod
❯ kubectl  get  po   --show-labels
NAME              READY   STATUS    RESTARTS   AGE   LABELS
anilpod           1/1     Running   0          57m   run=anilpod
ashuwebpod        1/1     Running   0          95m   run=ashuwebpod
manuwebpod        1/1     Running   0          45m   run=manuwebpod
murali36webpod1   1/1     Running   0          94m   run=murali36webpod1
rahulwebpod       1/1     Running   0          94m   run=rahulwebpod
tcwebpod          1/1     Running   0          93m   run=tcwebpod
veerupod2         1/1     Running   0          58m   run=veerupod2
vjwebpod          1/1     Running   0          87m   run=vjwebpod

```

## changing label 

### change in YAML 

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels: # this is for label creation of POD 
    x: helloashu # x is key and helloashu is a value 
  name: ashuwebpod # name of POD 
spec:
  containers:
  - image: dockerashu/ciscoweb:march2021v1 # docker image from Docker hub 
    name: ashuwebpod # name of container 
    ports:
    - containerPort: 80  # application port 
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```

### apply the changes 

```
❯ kubectl apply -f  webpod.yml
pod/ashuwebpod configured
❯ kubectl  get  po   --show-labels
NAME              READY   STATUS    RESTARTS   AGE   LABELS
anilpod           1/1     Running   0          59m   run=anilpod
ashuwebpod        1/1     Running   0          98m   x=helloashu

```

### deploying service 

```
❯ kubectl  apply  -f  ashuwebservice.yaml
service/ashus1 created
❯ 
❯ kubectl   get  service
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
ashus1       NodePort    10.96.32.247   <none>        1234:32172/TCP   11s
kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP          21h

```


### access pod container to check env variable 

```
❯ kubectl  exec  -ti  ashuwebpod  -- bash
[root@ashuwebpod projects]# 
[root@ashuwebpod projects]# 
[root@ashuwebpod projects]# env
LANG=en_US.UTF-8
x=webapp
HOSTNAME=ashuwebpod
KUBERNETES_PORT_443_TCP_PROTO=tcp
KUBERNETES_PORT_443_TCP_ADDR=10.96.0.1
KUBERNETES_PORT=tcp://10.96.0.1:443
PWD=/projects
HOME=/root
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP=tcp://10.96.0.1:443
TERM=xterm
SHLVL=1
KUBERNETES_SERVICE_PORT=443
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KUBERNETES_SERVICE_HOST=10.96.0.1
LESSOPEN=||/usr/bin/lesspipe.sh %s
_=/usr/bin/env
[root@ashuwebpod projects]# ls
app1  app2  app3  deploywebapp.sh
[root@ashuwebpod projects]# cat  deploywebapp.sh 
#!/bin/bash

if  [ "$x" == "website1" ]
then
    cp -rf  /projects/app1/*   /var/www/html/
    httpd -DFOREGROUND

elif  [ "$x" == "website2" ]
then
    cp -rf  /projects/app2/*   /var/www/html/
    httpd -DFOREGROUND

elif  [ "$x" == "website3" ]
then
    cp -rf  /projects/app3/*   /var/www/html/
    httpd -DFOREGROUND
else 
    echo "Wrong variable please contact to Docker Engineer !!"  >/var/www/html/index.html
    httpd -DFOREGROUND
fi

```

### changing env var and replacing the pod 

```
❯ ls
ashupod1.yaml       ashuwebservice.yaml webpod.yml
❯ kubectl   replace  -f webpod.yml  --force
pod "ashuwebpod" deleted
pod/ashuwebpod replaced
❯ kubectl  exec  -ti  ashuwebpod  -- bash
[root@ashuwebpod projects]# env
ANIL1_SERVICE_HOST=10.109.60.194
MURALI36S1_PORT_1234_TCP_ADDR=10.107.145.227
MANUSVC1_PORT_1235_TCP=tcp://10.104.239.174:1235
ANIL1_PORT=tcp://10.109.60.194:1234
MURALI36S1_SERVICE_PORT=1234
MANUSVC1_PORT=tcp://10.104.239.174:1235
VEERU_SERVICE1_SERVICE_PORT_MYPORT=1234
RAHULS1_PORT_1234_TCP_PORT=1234
MURALI36S1_SERVICE_HOST=10.107.145.227
LANG=en_US.UTF-8
MURALI36S1_PORT=tcp://10.107.145.227:1234
VEERU_SERVICE1_SERVICE_PORT=1234
x=website1

```

