master $ kubectl get all
NAME                        READY   STATUS    RESTARTS   AGE
pod/blue-5484cfbdc5-fqhvh   1/1     Running   0          19m
pod/blue-5484cfbdc5-gw4nt   1/1     Running   0          19m
pod/blue-5484cfbdc5-qtlmk   1/1     Running   0          19m
pod/blue-5484cfbdc5-r4hnp   1/1     Running   0          19m
pod/blue-5484cfbdc5-rttmq   1/1     Running   0          19m
pod/blue-5484cfbdc5-zbjbq   1/1     Running   0          19m
pod/red-5c9d9d686d-jwb68    1/1     Running   0          13s
pod/red-5c9d9d686d-lv5vn    1/1     Running   0          13s
pod/red-5c9d9d686d-sslcl    1/1     Running   0          13s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   29m

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/blue   6/6     6            6           19m
deployment.apps/red    3/3     3            3           13s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/blue-5484cfbdc5   6         6         6       19m
replicaset.apps/red-5c9d9d686d    3         3         3       13s


red deployment events

Events:
  Type    Reason     Age        From               Message
  ----    ------     ----       ----               -------
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/red-5c9d9d686d-sslcl to master
  Normal  Pulling    3m9s       kubelet, master    Pulling image "nginx"
  Normal  Pulled     3m7s       kubelet, master    Successfully pulled image "nginx"
  Normal  Created    3m7s       kubelet, master    Created container nginx
  Normal  Started    3m7s       kubelet, master    Started container nginx

blue deployment events
Explanation : since we set color=blue label to node01 and key=blue and value= blue  in deployment definition
the blue deployment select for node01 only.


Events:
  Type    Reason     Age        From               Message
  ----    ------     ----       ----               -------
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/blue-5484cfbdc5-fqhvh to node01
  Normal  Pulling    23m        kubelet, node01    Pulling image "nginx"
  Normal  Pulled     23m        kubelet, node01    Successfully pulled image "nginx"
  Normal  Created    23m        kubelet, node01    Created container nginx
  Normal  Started    23m        kubelet, node01    Started container nginx