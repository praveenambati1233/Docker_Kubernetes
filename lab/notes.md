
Final output
```shell script
master $ k get all --show-labels
NAME                             READY     STATUS    RESTARTS   AGE       LABELS
pod/mysql-bb7d87c68-qtjz2        1/1       Running   0          14m       app=wordpress,pod-template-hash=663843724,tier=mysql
pod/wordpress-6cc56bbd69-2zdcx   1/1       Running   0          3m        app=wordpress,pod-template-hash=2771266825,tier=frontend
pod/wordpress-6cc56bbd69-6vz7m   1/1       Running   0          3m        app=wordpress,pod-template-hash=2771266825,tier=frontend

NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE       LABELS
service/kubernetes        ClusterIP   10.96.0.1       <none>        443/TCP        3h        component=apiserver,provider=kubernetes
service/wordpress         NodePort    10.109.86.170   <none>        80:31004/TCP   26s       app=wordpress
service/wordpress-mysql   ClusterIP   10.109.102.29   <none>        3306/TCP       13m       app=mysql

NAME                        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
deployment.apps/mysql       1         1         1            1           14m       app=mysql
deployment.apps/wordpress   2         2         2            2           3m        app=wordpress

NAME                                   DESIRED   CURRENT   READY     AGE       LABELS
replicaset.apps/mysql-bb7d87c68        1         1         1         14m       app=wordpress,pod-template-hash=663843724,tier=mysql
replicaset.apps/wordpress-6cc56bbd69   2         2         2         3m        app=wordpress,pod-template-hash=2771266825,tier=frontend
```