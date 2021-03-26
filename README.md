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


