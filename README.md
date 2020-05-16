| sno  |  Topics  |
| ------------ | ------------ |
|  1  |  [YAML Examples](#YAML) |
|  2  |  [Optimize Docker Files](#Optimize-Docker-Files)  |
| 3 | [Creating pod using YAML](#Creating-pod-using-YAML) |

||
||
||
||


`docker run` command is used to run a container from an image.

`docker ps `  list containers 

`docker run image-name` check in local, if not present, pull from docker humber and runs the container 

`docker pull image-name ` pulls the image 

`docker rm container-id ` remove running container 

`docker rmi image-name`  remove image 

`docker ps`   running containers 

`docker ps -a`  both running and non-running containers 


`docker run -it image-name` Run in intractive mode and detached 

`docker build . -t voting-app` runs DockerFile in the current directory with tag: *voting-app*

edit the deployment `kubectl edit deployment.v1.apps/web-dashboard` 

setting the namespace `kubectl config set-context --current --namespace=<insert-namespace-name-here>` 

list of images in a pod `kubectl get pods my-app-976b6864f-5mchm -o=jsonpath="{..image}"` [basically this commands return pulled image and latest image, not sure why ? ]

more : https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/#list-container-images-by-pod


scale the pod `kubectl scale -n default replicaset my-app-976b6864f --replicas=3`

update the image in the deployment `kubectl set image deployment/<deployment-name>  <container-name>=<new iamge> --record`

Get Deployments on particular namespace `kubectl get deployment  --namespace=app-space`

Get Pods on particular namespace `kubectl get pods --namespace=app-space`

Get Pods on particular namespace `kubectl get services  --namespace=app-space`

To get all the resouces `kubectl get all --all-namespaces`


create deployment and scale to 3 replicaset








------------

*docker run -it -p applicationPort:containerPort -v myMountlocation:image-name/location -u root image-name* ; runs in intractive and detached mode with mapping public port and private port and volumn setup for the backup 

Example : Run an instance of kodekloud/simple-webapp with a tag blue and map port 8080 on the container to 38282 on the host.

> `docker run -it -p 38282:8080 kodekloud/simple-webapp:blue`

------------

**Which of the below ports are published on Host?**
Hint : Run the command docker ps and look under the PORTS column.Ports on the left(before ->) are published on the host

**Which of the below ports are the exposed on the CONTAINER?**
Run the command docker ps and look under the PORTS column.Ports on the right(after ->) are exposed on the container

```bash
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS NAMES
1e03faef1f76        nginx:alpine        "nginx -g 'daemon of…"   57 seconds ago      Up 56 seconds       0.0.0.0:3456->3456/tcp, 0.0.0.0:38080->80/tcp trusting_elgamal
```
------------

Run a container named blue-app using image kodekloud/simple-webapp and set the environment variable APP_COLOR to blue. Make the application available on port 38282 on the host. The application listens on port 8080.

> $ docker run -p 38282:8080 -e APP_COLOR=blue --name blue-app kodekloud/simple-webapp

------------

Deploy a mysql database using the mysql image and name it mysql-db.
Set the database password to use db_pass123. Lookup the mysql image on Docker Hub and identify the correct environment variable to use for setting the root password.


>$ docker run -e MYSQL_ROOT_PASSWORD=db_pass123 --name mysql-db  mysql

------------

Run an instance of the ubuntu image to run the sleep 1000 command at startup
Run it in detached mode.

> docker run -d ubuntu sleep 1000


------------

# YAML





------------



# Optimize Docker Files

https://www.youtube.com/watch?v=KLOdisHW8rQ
https://www.youtube.com/watch?v=T4Df5_cojAs&t=373s

> Use multi stage builds 
https://docs.docker.com/develop/develop-images/multistage-build/

> Speed up your build with this optimized Dockerfile  https://www.youtube.com/watch?v=oZ9nyCWERYc



K8s 

https://www.youtube.com/watch?v=Qzy6nmk0eI8&t=106s


# Creating pod using YAML

> K8s uses YAML files as inputs for the creation of PODs, Replica sets, deployment, services , volums etc.

**Best sutiable softwares for Yaml creation**
- IDE : pycharm with k8s plugin
- Validation : http://www.yamllint.com/ 

Structure as follows ( Mandatory fields for every yaml file)
```yaml
apiVersion:
Kind:
metadata:

spec:
```

Create nginx pod using YAML

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    name: myapp-pod
    app: my-app
    type: pod
spec:
  containers:
    - name: nginx-image
      image: nginx

```

create redis pod with invalid image 

```shell
apiVersion: v1
kind: Pod
metadata:
  name: redis
  labels:
    name: redis-label
    app: db
spec:
  containers:
    - name: redis
      image: redis123
```


```shell
master $ kubectl apply -f redis.yml
pod/redis created
master $ kubectl get pods
NAME            READY   STATUS         RESTARTS   AGE
myapp-pod       1/1     Running        0          14m
newpods-69wx8   1/1     Running        0          14m
newpods-t7n4r   1/1     Running        0          14m
newpods-wqhcp   1/1     Running        0          14m
redis           0/1     ErrImagePull   0          7s
```
After correting the image name to **redis**
```shell
master $ vi redis.yml
master $ kubectl apply -f redis.yml
pod/redis configured
master $ kubectl get pods
NAME            READY   STATUS    RESTARTS   AGE
myapp-pod       1/1     Running   0          16m
newpods-69wx8   1/1     Running   0          16m
newpods-t7n4r   1/1     Running   0          16m
newpods-wqhcp   1/1     Running   0          16m
redis           1/1     Running   0          100s
```

# Replication Controllers and ReplicaSets

> Controllers are brain behind K8s.
> Controllers are the processors that  monitor k8s objects and respond accordingly.

**Replication Controller**



K8s Commands :

create pod 
`kubectl apply -f fileName.yml` 

Sample pod defintion yml file

`kubectl run <pod-name> --image <image-name>`


Remove pod  `kubectl delete pod <pod-name>`

get pods `kubectl get pods`

get nodes `kubectl get nodes`

scale replicaSet `kubectl scale --replicas=6 -f fileName.yml` [this does not effect the replicaset file]

replace pod/replicaset file `kubectl replace -f fileName.yml`

replace replicas `kubectl scale --replicas=6 replicaset myapp-replicaset ` [but changes does not reflect in .yml file]

get replicaSets `kubectl get replicaset`

delete replicaSet `kubectl delete replicaset myapp-replicaset` [also delete underlaying pods ]

update repilcaSet `kubectl edit replicaset replicaSetName` [get replicaSet name using command `kubect get replicaset`]

all about describe 
`kubectl describe  deployment <deployment-name>`
`kubectl describe  pod <pod-name>`
`kubectl describe  replicaset <replicaset-name>`



Create a new Deployment with the below attributes using your own deployment definition file
Name: httpd-frontend; Replicas: 3; Image: httpd:2.4-alpine

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd-frontend
  labels:
    name: mydeployment-app
    type: front-end
spec:
  #Get the pod template to create new pod for reference
  template:
    metadata:
      name: httpd-pod
      labels:
        name: httpd
    spec:
      containers:
        - name: httpd-image
          image: httpd:2.4-alpine
  replicas: 3
  #Link to pod label
  selector:
    matchLabels:
      name: httpd
```

output :

```shell
master $ kubectl get all
NAME                                       READY   STATUS             RESTARTS   AGE
pod/httpd-frontend-5cd44f5b67-5s7lz        1/1     Running            0          108s
pod/httpd-frontend-5cd44f5b67-76v97        1/1     Running            0          108s
pod/httpd-frontend-5cd44f5b67-pq5gb        1/1     Running            0          108s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   15m

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/httpd-frontend        3/3     3            3           108s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/httpd-frontend-5cd44f5b67        3         3         3       108s
```



Node

Kubernetes is configured on one or more Nodes. A node is a machine – physical or virtual – on which kubernetes is installed. A node is a worker machine and this is were containers are hosted. 

But what if the node on which our application is running fails? Well, obviously our application goes down. So you need to have more than one nodes for **high availability **and **scaling**. 

A cluster is a set of nodes grouped together. This way even if one node fails you have your application still accessible from the other nodes. Moreover having multiple nodes helps in sharing load as well. 

A cluster is a set of nodes grouped together. This way even if one node fails you have your application still accessible from the other nodes. Moreover having multiple nodes helps in sharing load as well. 

![](https://github.com/praveenambati1233/docker/blob/master/cluster.PNG)

Now we have a cluster, but who is responsible for managing the cluster? Were is the information about the members of the cluster stored? How are the nodes monitored? When a node fails how do you move the workload of the failed node to another worker node? That’s were the Master comes in. The master is another node with Kubernetes installed in it, and is configured as a Master.   The master watches over the nodes in the cluster and is responsible for the actual orchestration of containers on the worker nodes. 

![](https://github.com/praveenambati1233/docker/blob/master/MasterNodeAndWorkerNode.PNG)

**Kubernetes Architecture**

![](https://github.com/praveenambati1233/docker/blob/master/k8sArch.PNG)


**Pod**

The containers are encapsulated into a Kubernetes object known as PODs.


Each Pod get it's own IP address in k8s 

**Deployment**

It is Kubernetes object that comes higher in the hierarchy, the deployment provides us with the capability to **upgrade** the underlying instances seamlessly using **rolling updates.** **Undo changes** and **pause** and **resume changes** as required.

![](https://github.com/praveenambati1233/docker/blob/master/deployment.png)


When you first create a deployment it triggers a rollout a new rollout creates a new deployment revision.

Let's call it revision 1, in the future when the application is upgraded meaning when the container version is updated to a new one a new rollout is triggered and a new deployment revision is created named revision 2.

```shell
C:\Users\praveena\IdeaProjects\Kubernetes>kubectl rollout status deployment/frontend
deployment "frontend" successfully rolled out

C:\Users\praveena\IdeaProjects\Kubernetes>kubectl rollout history deployment/frontend
deployment.extensions/frontend
REVISION  CHANGE-CAUSE
1         <none>
```

There are two types of upgrades in deployment stratagy
1. Create ( downtime will be there as we bring down deployment at a time)
2. Rolling update ( default )

**Example**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    app: mywebsite
    tier: frontend
spec:
  replicas: 4
  template:
    metadata:
      name: myapp-pod
      # Labeling is important to refer and create new pod by replicaSet
      labels:
        app: myapp
    spec:
      containers:
        - name: nginx
          image: nginx
  selector:
    matchLabels:
      # Refer Label from pod template
      app: myapp
```
create deployment
```shell
kubectl create -f deployments-definition.yml
```
JFYI you can also create deployment by using below command

```
kubectl run nginx --image=nginx
```

A new deployment will be rolledout

```shell
C:\Users\praveena\IdeaProjects\Kubernetes>kubectl rollout history  deployment/frontend
deployment.extensions/frontend
REVISION  CHANGE-CAUSE
1         <none>
```

Change Request :` image: library/nginx:1.7.1`

Alternate way to update deplyments 

`kubectl edit deployment.v1.apps/<deployment-name>`

```shell
kubectl apply -f deployments-definition.yml
deployment.apps/frontend configured
```

A new version will be created

```shell
C:\Users\praveena\IdeaProjects\Kubernetes\src\deployments>kubectl rollout undo deployment/frontend
deployment.extensions/frontend rolled back
```

```shell
C:\Users\praveena\IdeaProjects\Kubernetes>kubectl rollout history  deployment/frontend
deployment.extensions/frontend
REVISION  CHANGE-CAUSE
1         <none>
2         <none>

```

If you want to **undo** your changes in the deployment. Below command has to run

```shell
C:\Users\praveena\IdeaProjects\Kubernetes\src\deployments>kubectl rollout undo deployment/frontend
deployment.extensions/frontend rolled back
```

look at the revision 2, 3. Before undo our changes was 1,2.
Internally 
K8s **records** the revision history with what command we rollout.
when we undo k8s create new reivions in this case it is 3 and executes the revision 1 rollout. 
Note - You couldn't see CHANGE-CAUSE details because I have used --record when I run the kubectl create command.

```shell
C:\Users\praveena\IdeaProjects\Kubernetes\src\deployments>kubectl rollout history  deployment/frontend
deployment.extensions/frontend
REVISION  CHANGE-CAUSE
2         <none>
3         <none>
```

upgrade and undo commands works as below.

![](https://github.com/praveenambati1233/docker/blob/master/rollingupgrade.PNG)

```shell
C:\Users\praveena\IdeaProjects\Kubernetes\src\deployments>kubectl rollout status deployment/frontend
Waiting for deployment "frontend" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "frontend" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "frontend" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "frontend" rollout to finish: 3 of 4 updated replicas are available...
deployment "frontend" successfully rolled out

```


# Service

The service is in fact like a virtual server inside the node. Inside the cluster,
It has its own IP address and that IP address is called the cluster IP of the service.

Service can help us by mapping a port on the node to a port on the pod.

Types of Services :
1. NodePort
2. ClusterIp
3. LoadBalancer 

**1. NodePort**

Service listen to a port on the node and forward request on that port to a port on the pod running the web application this type of service is known as a **node port** service. Because the service listens to port on the node and forward requests to the pods.

**2. ClusterIp**

Above is about a service mapped to a single pod. But that's not the case all the time. What do you do when you have multiple pods? In the production environment you have multiple instances of your web application running for high availability and load balancing purposes.  In this case we have multiple similar pods running our web application. They all have the same labels with a key app and set to a value of myapp. The same label is used as
a selector during the creation of the service. So when the service is created it looks for a matching pod with the label and finds three of them. The service then automatically selects all the three pods as endpoints to forward the external requests coming from the user.
we  don't have to do any additional configuration to make this happen.
And if you're wondering what algorithm it uses to balance the load across the three different pods, it uses a **random algorithm**. Thus the service acts as a builtin load balancer to distribute load across different pods.

And finally let's look at what happens when the pods are distributed across multiple nodes. In this case,
we have the web application on pods on separate nodes in the cluster.
When we create a service without us having to do any additional configuration, kubernetes automatically creates a service that spans across all the nodes in the cluster and maps the target port to the same node port on all the nodes in the cluster.
This way you can access your application using the IP of any node in the cluster and using the same port number which in this case is 30008. As you can see using the IP of any of these nodes.  And I'm trying to curl to the same port and the same port is made available on all the nodes part of the cluster. 

To summarize, in any case whether it be a single pod on a single node, multiple pods on a single node or multiple pods on multiple nodes, the service is created exactly the same without you having to do  To summarize, in any case whether it be a single pod on a single node, multiple pods on a single node or multiple pods on multiple nodes, the service is created exactly the same without you having to do  any additional steps during the service creation. When Pods are removed or added, the service is automatically updated making its highly flexible and adaptive. Once created you won't typically have to make any additional configuration changes.


 **3. LoadBalancer**
 
 



















![](https://github.com/praveenambati1233/docker/blob/master/serviceNodePort.PNG)



# CMD and ENTRYPOINT in Docker

> CMD instruction the command line parameters passed will get replaced entirely.
>ENTRYPOINT the command line parameters will get appended. 

**usecase:**

`$docker run ubuntu --image=ubuntu`

Docker creates a container from the Ubuntu image and execute Command (CMD) instruction /bin/bash program and looks for bash terminal since it is not 
attached while running the docker run command it immediately exits. 

```shell
FROM scratch
....
....

CMD ["/bin/bash"]
```

So how do you specify a different command to start the container ?

One option is to append the command to the docker run command and that way it overrides the default command specified within the image.

```shell
$docker run ubuntu sleep 5 // this overrides /bin/bash to sleep 5
```

so how to make this permanent  ? when you run ubuntu image by default it should sleep for 5 seconds

To make this happen create sleeper version of ubuntu image with CMD instruction to execute at the time of container creation.

*dockerFile - ubuntu-sleeper*

```shell
FROM ubuntu
CMD ["sleep", "5"]
```

`$docker run ubuntu-sleeper `

Currently it is hardcoded to 5 seconds. let's say now you want increase the sleep time. As we learn before, one option is to run the docker run command with the new command appended to it.

`$docker run ubuntu-sleeper sleep 10`

In this case sleep 10 and so the command that will be run at startup will be sleep 10.

But it doesn't look very good. the new version of ubuntu image that we created sounds ubuntu-sleeper but we have to send command as "sleep 10"

so to elimiate the "sleep" command  in the run command, we need to use **ENTRYPOINT** instruction.

![](https://github.com/praveenambati1233/docker/blob/master/cmdvsentrypoint.PNG)


In Kubernetes,  

Docker CMD = args: [""]
Doker ENTRYPOINT = command: [""]


> Inspect the file 'Dockerfile2' given at /root/webapp-color. What command is run at container startup?Inspect the file 'Dockerfile2' given at /root/webapp-color. What command is run at container startup?

```shell
cat Dockerfile2FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

CMD ["--color", "red"]
```
Answer : python appy.py --color red

> Inspect the two files under directory 'webapp-color-2'. What command is run at container startup?Inspect the two files under directory 'webapp-color-2'. What command is run at container startup?

```shell
master $ cat Dockerfile2FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

CMD ["--color", "red"]
```

```yaml
master $ cat webapp-color-pod.yaml
apiVersion: v1
kind: Podmetadata:  name: webapp-green
  labels:
      name: webapp-greenspec:
  containers:
  - name: simple-webapp
    image: kodekloud/webapp-color
    command: ["--color","green"]
```

Answer :  --color green
Hint : The 'command' (entrypoint) is overridden in the pod definition. So the answer is --color green

>Inspect the two files under directory 'webapp-color-3'. What command is run at container startup?
Assume the image was created from the Dockerfile in this folder

```shell
master $ cat Dockerfile2FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

CMD ["--color", "red"]
```

```shell
master $ cat webapp-color-pod-2.yamlapiVersion: v1
kind: Pod
metadata:
  name: webapp-green
  labels:
      name: webapp-green
spec:
  containers:
  - name: simple-webapp
    image: kodekloud/webapp-color
    command: ["python", "app.py"]
    args: ["--color", "pink"]
```
**Answer** : python app.py --color pink
**Explanation** :
CMD instruction the command line parameters passed will get replaced entirely.
Docker CMD = args: [""] in Kubernetes

# Config Maps / Environment variables

configmap/configmap-multikeys.yaml 

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: special-config
  namespace: default
data:
  SPECIAL_LEVEL: very
  SPECIAL_TYPE: charm
```

Above configMap data configurated in the pod resource.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: k8s.gcr.io/busybox
      envFrom:
      - configMapRef:
          name: special-config
  ```

# Docker Security




# Service Account 

The concept of service accounts is linked to other security related concepts such as authentication,authorization, role-based access controls etc

for CDAD - only concept understanding.

As service account could be an account used by an application to interact with a Kubernetes cluster.
For example a monitoring application like Prometheus is used as a service account to pull the Kubernet--es API for performance metrics. An automated build tool like Jenkin's uses service accounts to deploy applications on the Kubernetes cluster.

If you look  at the list of service accounts, you will see that there is a default service account that exists already. For every namespace in Kubernetes, a service account named "default" is automatically created. Each namespace has its own default service account. Whenever a pod create, The default service account and it's token are automatically mounted to that pod as a volume mount. For example we have a simple pod definition file that creates a pod using my custom Kubernetes dashboard image.
We haven't specified any secrets or Volume mounts in the definition file.However when the pod is created if you look at the details of the pod by running the kubectl describe pod command you'll see that a volume is automatically created from the secret named "default-token" which is in fact the secret containing the token for this default service account.
The secret token is mounted at location /var/run/secrets/kubernetes.io/service/account inside the pod.

![](https://github.com/praveenambati1233/docker/blob/master/defaultServiceAccount.PNG)

So from inside the pod if you run the ls command to list the contents of the directory you will see the secret monitored as three separate files.
The one with the actual token is the file named "token".


```shell
C:\Users\praveena>kubectl exec -it frontend-7c8875466f-cspjg ls /var/run/secrets/kubernetes.io/serviceaccount
ca.crt  namespace  token
```

If you view contents of that file you will see the token to be used for accessing the Kubernetes API.

```shell
C:\Users\praveena>kubectl exec -it frontend-7c8875466f-cspjg cat /var/run/secrets/kubernetes.io/serviceaccount/token
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tZG5tOWciLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjQyMzMwM2E3LThlYTMtNDlhOC1iYWY1LTkwOTM2ODNmOWRjYiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.TgVPp1Ca8WmiN_sTqkBVSDer0JANa9phA54_Q-Vf5cWl8fqghg3kVdtpL9_kO8B3j4FSHlDuYkPNyYHH_xWWIMwSFVwJSYnJMd_rAfBx6y0B6pNaGvr-kQXohglXf3NBJaKT7oM4OpRNXxtrUpTfz306E-TO226-1hQJrcj0uH1TOQPdmO5DdFvqDtaQ0Wl7fsesbzr8rF5gGFhidoCb3pqNLnluZceT-RWxvZ_0yBxQooimqR0RffM3TQWZYAcihe6VTxRlYudZdw8EDcUGwdK8S3d57rTWj4sLrbA30lXe6nd3Fruz-9YG4rAa-S2uovsQUm7EbYdDGWLXmE7RdA
```

Now remember that the default service account is very much restricted.
It only has permission to run basic Kubernetes API queries. If you'd like to use a different service account. such as the one we just created modified the pot definition file to include a service account field and specify the name of the new service account. Remember, you cannot edit the service account of an You must delete and recreate the pod. **However in case of a deployment you will be able to get the service account as any changes to the pod definition file will automatically trigger a new rollout for the deployment.
So the deployment will take care of deleting and recreating new pods with the right service account.**

When you look at the pod details now you'll see that the new service account is being used.
So remember Kubernetes automatically mount the default service account.
If you haven't explicitly specified any you may choose not to mount a service account automatically by setting the auto mount service account token field to false in the pod spec section. `automountServiceAccountToken: false`

**Service account creation** 

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
 name: dashboard-sa
```

To use service account in POD

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hello-pod
  labels:
    type: pod
spec:
  containers:
    - name: ubuntu
      image: ubuntu
      args: ["sleep","10"]
  serviceAccountName: dashboard-sa
```

How to get the service token for service account dash

```shell
master $ kubectl describe serviceaccount dashboard-sa
Name:                dashboard-sa
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   dashboard-sa-token-hn6sh
Tokens:              dashboard-sa-token-hn6sh
Events:              <none>
master $ kubectl describe secret dashboard-sa-token-hn6sh
Name:         dashboard-sa-token-hn6shNamespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: dashboard-sa
              kubernetes.io/service-account.uid: 5f6f1f8a-9d34-473b-9ff5-e8ca6b93bd67

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1025 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6Il9fazlVWXhqWXFRanZXOG9Db0IwejE1aFZIYWRGbUs0VTZLSTJoTkU2TE0ifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRhc2hib2FyZC1zYS10b2tlbi1objZzaCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkYXNoYm9hcmQtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI1ZjZmMWY4YS05ZDM0LTQ3M2ItOWZmNS1lOGNhNmI5M2JkNjciLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.CfWcW9fPH0NeyXG5uxqu1ornIFw3Nh4VrgZR9cUWZYpKK20RjSW0KMhIlJgQuUZQAM3XZJzqmK50opQ4JxXIZI3LGK1Nd1QIip6lHiFj7stNK5EldGXDjjNy5G8VbELJ5phdTAWyDBZIIyfuMDze2KEEtuNw4gDIZGTn73Bm_5tEr3KvVSJegUrrioMlE-BLn05RFc1MyG5HgZm88FtrOWDx8aenuGzeJsGxachKg__A4h2LvwuuqNa1sq01Ssw04RMrmhJHNI2jwE53wAJfBbSeYN9WIj7LNVO3FP_n3AngeFL9smqUEXZP75iwqN-Ued0ZNQaESyM-i9IvmyLJXg
```


#Multi-container 




# Readness probe

If you look below simple-webapp-2 is up and running but still the user request getting failed. Because simple-webapp-2 takes 80 sec to start the application and will get ready to accept traffic ( boot time )
```shell
master $ kubectl get all
NAME                  READY   STATUS    RESTARTS   AGE
pod/simple-webapp-1   1/1     Running   0          71s
pod/simple-webapp-2   1/1     Running   0          26s

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1       <none>        443/TCP          4m22s
service/webapp-service   NodePort    10.109.13.241   <none>        8080:30080/TCP   71s
master $ ./curl-test.sh
Message from simple-webapp-1 : I am ready! OK

Failed

Message from simple-webapp-1 : I am ready! OK

Failed

Failed
```


program:

```shell
for i in {1..20}; do
   kubectl exec --namespace=kube-public curl -- sh -c 'test=`wget -qO- -T 2  http://webapp-service.default.svc.cluster.local:8080/ready 2>&1` && echo "$test OK" || echo "Failed"';
   echo ""
```





# Pod Design

**Labels and selectors:**

Two types of selecting the objects using selectors

1. Equality-based requirement
`= == !=`
2. Set-based requirement
`in,notin and exists`

**Examples:** 
```shell
#simple way
$kubectl get po -l env=dev

#Set-based 
$ kubectl get po -l 'env in (dev)'
$ kubectl get all -l 'env in (prod)'
$ kubectl get po -l 'env in (prod),bu in (finance),tier in (frontend)'

#Equality-based
$ kubectl get po --selector env=dev
$ kubectl get all --selector env= prod'
$ kubectl get po --selector env=prod,bu=finance,tier=frontend'
```

**overwrite the label**

`$ kubectl label po db-1-5lj5n env=prod --overwrite`

**Get the the label**

`$ kubectl get po -L <labelname>`

```shell
master $ kubectl get po -L env
NAME          READY   STATUS    RESTARTS   AGE     **ENV**
app-1-27fvf   1/1     Running   0          7m3s    devapp-1-7d6d8   1/1     Running   0          7m3s    dev
app-1-m87z4   1/1     Running   0          7m3s    dev
app-1-zzxdf   1/1     Running   0          7m2s    prod
app-2-nf4sl   1/1     Running   0          7m3s    prod
auth          1/1     Running   0          7m2s    prod
db-1-5lj5n    1/1     Running   0          7m3s    prod
db-1-cx9gq    1/1     Running   0          7m3s    dev
db-1-kbhrc    1/1     Running   0          7m3s    dev
db-1-rfjc7    1/1     Running   0          2m12s   dev
db-1-xfb8f    1/1     Running   0          7m3s    dev
```
**Add annoattion to the exiting pod**

`kubectl annotate po pod-name myannotation='my description`

**Add label to the exiting pod**

`kubectl label  po pod-name labels=app1=ver1



