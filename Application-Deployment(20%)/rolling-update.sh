#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Deployment strategy key fields
# maxSurge
# maxUnavailable

# Task
# Create a new deployment myrollingupdate in the chapter-02 namespace that uses the redis:6.0-alpine image
# it should have 10 replicas
# maxSurge should be 50%
# maxUnavailable should be 10%
# change the container image to redis:7.0-alpine
# rollback the last deployment
kubectl create deployment myrollingupdate --image=redis:6.0-alpine --replicas=10 --namespace chapter-02 --dry-run=client -o yaml > myrollingupdate.yaml
# edit myrollingupdate.yaml
# spec.strategy
rollingUpdate: 
    maxSurge: 50%
    maxUnavailable: 10%

kubectl create -f myrollingupdate.yaml
kubectl set image deployment myrollingupdate redis=redis:7.0-alpine
kubectl rollout history deployment myrollingupdate
kubectl rollout undo deployment myrollingupdate --to-revision=1