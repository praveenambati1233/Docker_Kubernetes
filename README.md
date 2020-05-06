




| sno  |  Topics  |
| ------------ | ------------ |
|  1  |  [YAML Examples](#YAML) |
|  2  |  [Optimize Docker Files](#Optimize-Docker-Files)  |
| 3 | [Creating pod using YAML](#Creating-pod-using-YAML) |




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


K8s Commands :

Remove pod 

`kubectl delete pod <pod-name>`

get pods

`kubectl get pods`

get nodes

`kubectl get nodes`

