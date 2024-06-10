#!/bin/bash

# Materials from https://www.youtube.com/watch?v=9uxG6un9lpA&ab_channel=TheAzureguy

# Question 1.1
# Create a new service account named backend team. Print out the token for the service account in YAML format
kubectl create serviceaccount backend-team
kubectl get serviceaccount -o yaml 

# Question 1.2
# Create a pod named backend that uses the image nginx and the identity backend team for running processes
kubectl run backend --image=nginx --dry-run=client -o yaml > q6.yaml
#Edit the q6.yaml and add below
serviceAccountName: backend-team

# Question 1.3
# Shell to the running container and print out the token of the service account
kubectl exec -it backend -- bin/sh
cd var/run/secrets/kubernetes.io/serviceaccount
cat token