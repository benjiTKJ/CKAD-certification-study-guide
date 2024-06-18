#!/bin/bash

# Materials from https://www.youtube.com/watch?v=lbnCjTAqTAw&ab_channel=TheAzureguy

# Question 1.1
# Create a service named myapp of type clusterip that exposes port 80 to the target port 80
kubectl create service myapp clusterip --tcp=80:80 --dry-run=client -o yaml > q14.yaml
kubectl create -f q14.yaml

# Question 1.2
# Create a deployment named myapp that creates 1 replica running the image nginx. Expose the container on port 80
kubectl create deployment myapp --image=nginx --replicas=1 --port=80 --dry-run=client -o yaml > q14b.yaml
kubectl create -f q14b.yaml

# Question 1.3
# Verify port 80 is exposed - list the endpoint values
kubectl get pod -o wide
kubectl describe service myapp

# Question 1.4
# Scale the deployment to 2 replicas
kubectl scale deployment myapp --replicas=2

# Question 1.5
# Create a temporary pod using the image busybox and run wget command against the IP address of the service
kubectl run temp --image=busybox --restart=Never -it --rm -- wget -O- ip-address-of-service 

# Question 1.6
# Change the service type so that the pods can be reached from the outside of the cluster
kubectl edit service myapp 
# Change type ClusterIP to LoadBalancer

# Question 1.7
# Run wget command against the service from outside the cluster
wget -O- ip-address-of-service