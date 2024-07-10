#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# pod.spec.containers.resources.requests - specify the minimum amount of resources a container needs to function properly
# pod.spec.containers.resources.limits - specify the maximum amount of resources a container can consume
# ResourceQuota - maximum amount of resources per namespace, including the number of objects that can be created

# Task
# Create a pod myresourcepod based on the nginx container image in the chapter-04 namespace
# Specify a cpu requests of 500m and 250Mi of memory for the container
kubectl run myresourcepod --image=nginx --namespace chapter-04  --dry-run=client -o yaml > myresourcepod.yaml
# edit myresourcepod.yaml
# spec.containers.resources
requests:
    cpu: 500m
    memory: 250Mi

kubectl apply -f myresourcepod.yaml