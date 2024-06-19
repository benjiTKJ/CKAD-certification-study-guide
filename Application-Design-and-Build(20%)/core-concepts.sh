#!/bin/bash

# Materials from https://www.youtube.com/watch?v=d-gPOU31ogY&ab_channel=TheAzureguy

# Question 1.1
# Create a new pod named speed running the image nginx:1.17.10 using port 80. The pod should be in the namespace ckad1
kubectl create namespace ckad1
kubectl run speed --image=nginx:1.17.10 --port=80 --namespace ckad1

# Question 1.2
# Get the pod ip address
kubectl get pod -o wide
# or 
kubectl describe pod speed --namespace ckad1

# Question 1.3
# Create a temporary pod that uses the busybox image and execute a wget command inside of the container. The wget command should access the endpoint exposed by the nginx container
kubectl run temppod --image=busybox --rm -it --restart=Never --namespace ckad1 -- wget -O- ip-address-of-speed:80 

# Question 1.4
# Get the logs of speed container
kubectl logs speed

# Question 1.5
# Add the environment variable DB_URL=postgresql://speeddb:5432 and DB_USERNAME=trixie
kubectl edit pod speed

env: 
- name: DB_URL
  value: postgresql://speeddb:5432
- name: DB_USERNAME
  value: trixie

kubectl exec speed -it --namespace ckad1 -- env

# Question 1.6
# Open a shell for the nginx container and inspect the contents of the current directory
kubectl exec speed -it --namespace ckad1 -- bin/sh
ls -la

# Question 1.7
# Create a YAML manifest for a pod named loop that runs the busybox image as a container. The container should run the following command: for i in {1..10}; do echo "Welcome $i time"; done What is the status of the pod
kubectl run loop --image=busybox --dry-run=client -o yaml > task7.yaml -- bin/sh
- args: 
  - bin/sh
  - -c
  - 'for i in 1 2 3 4 5 6 7 8 9 10; do echo "Welcome $i times"; done'

# Question 1.8
# Edit the pod loop change the command to run in an endless loop. Each ireration should echo the current date
kubectl edit pod loop
- while true, do date; sleep 10; done

# Question 1.9
# Delete the namespace ckad1
kubectl delete namespace ckad1
