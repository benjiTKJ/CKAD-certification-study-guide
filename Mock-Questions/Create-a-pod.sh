#!/bin/bash

# Materials from https://www.youtube.com/watch?v=k9yk5DYZCJU&list=PLfeid9nyFRy96tGhBXeSvHlSCEXyc4wwo&ab_channel=TheAzureguy

# Question 1.1:
# Create a namespace called ckad
kubectl create namespace ckad

# Question 1.2:
# In the ckad namespace create a pod name pod1 with image of nginx 2.3.5 and expose port 80
kubectl run pod1 --image=nginx:2.3.5 --port=80 --namespace=ckad

# Question 1.3:
# Retrieve the IP address of the pod
kubectl describe pod pod1 --namespace=ckad

# Question 1.4:
# Run a temporary pod using busybox image, shell into it and run a wget against pod1
kubectl run busybox --image=busybox --rm -it -- bin/sh
wget IP_ADDRESS

# Question 1.5:
# View the logs of pod1
kubectl logs pod1 --namespace=ckad
