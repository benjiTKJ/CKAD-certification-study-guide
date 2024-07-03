#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task 1
# Fix myfailingdeployment 
kubectl edit deployment myfailingdeployment
# edit spec.template.spec.containers
- image: nginx

# Task 2
# Create a new deployment name mycustomdeployment in chapter-02 namespace that uses the nginx container image
# The deployment should have 10 replicas
# The deployment should use rolling updates strategy
kubectl create deployment mycustomdeployment --replicas=10 --image=nginx --namespace chapter-02

# Task 3
# Delete both deployments
kubectl delete deployment myfailingdeployment mycustomdeployment