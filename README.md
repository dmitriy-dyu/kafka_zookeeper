## Kafka SSl

#### Folder Structure

```
 kafka
 ├── certs
 │   ├── kafka.client.truststore.jks
 │   ├── kafka.server.keystore.jks
 │   └── kafka.server.truststore.jks
 ├── Chart.yaml
 ├── Dockerfile
 ├── templates
 │   └── kafka.yaml
 └── values.yaml 
 zookeeper
 ├── Chart.yaml
 ├── templates
 │   └── zookeeper.yaml
 └── values.yaml
 README.md
 start.sh
```
To run Kafka with SSL need to do the following:

The task has been implemeneted on minikube cluster

1.  Suggested minikube start configuration:

      ```minikube start --vm-driver=docker```
      
      ```minikube update-context```    
2.  Deploy Zookeeper stafulset to minikube cluster

      ```helm upgrade -i zookeeper zookeeper/  --namespace default -f ./zookeeper/values.yaml --atomic --debug```
   
3.  Run bash script `build.sh` value of Docker mage name:
   
     ```/bin/bash build.sh localhost/kafka:v1```
     
     *The docker image will be build with specific name and this name will be put into Kafka helm file `values.yaml`*
   
4.  Deploy Kafka statefulset to minikube cluster

    ```helm upgrade -i kafka kafka/  --namespace default -f ./kafka/values.yaml --atomic --debug```
    
    *Note that if you spin them up too fast sequentially, kafka will Error, then CrashLoopBackOff until it can connect to Zookeeper.*
    
5.  After Kafka pod is ready, let's create new topic

    ```kafka-topics.sh --create --topic test --zookeeper zk-0.zk-svc.default.svc.cluster.local:2181 --partitions 1 --replication-factor 1```
    
6.  Run a producer and type something then press ENTER

    ```kafka-console-producer.sh --broker-list localhost:9093 --topic test  --producer.config /opt/kafka/config/server.properties```

7.  Since previous command is blocking you may run command below in a separate terminal session
    You should see anything you type in producer session.
    
    ```kafka-console-consumer.sh --bootstrap-server localhost:9093 --topic test --new-consumer --consumer.config /opt/kafka/config/server.properties --from-beginning```