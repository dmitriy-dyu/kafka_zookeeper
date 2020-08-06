#!/bin/bash

IMAGE=$1

eval $(minikube -p minikube docker-env)  # to re-use the Docker daemon inside the Minikube instance

docker build -t ${IMAGE} ./kafka/

sed -i "/imageName:/c imageName: ${IMAGE}"  kafka/values.yaml     #update image version in Kafka values.yaml
