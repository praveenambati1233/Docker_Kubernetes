

`docker run` command is used to run a container from an image.

`docker ps `  list containers 

`docker run image-name` check in local, if not present, pull from docker humber and runs the container 

`docker pull image-name ` pulls the image 

`docker rm container-id ` remove running container 

`docker rmi image-name`  remove image 

`docker ps`   running containers 

`docker ps -a`  both running and non-running containers 


`docker run -it image-name` Run in intractive mode and detached 


------------



`docker run -it -p applicationPort:containerPort -v myMountlocation:image-name/location -u root image-name`  runs in intractive and detached mode with mapping public port and private port and volumn setup for the backup 

Example : Run an instance of kodekloud/simple-webapp with a tag blue and map port 8080 on the container to 38282 on the host.

`docker run -it -p 38282:8080 kodekloud/simple-webapp:blue`


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










