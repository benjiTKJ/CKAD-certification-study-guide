#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# readinessProbe - if the container is ready to recieve traffic
# livenessProbe - health check for container if its alive
# startupProbe - if application has startup in a time window

# Task
# Modify myreadinesspod.yaml file to add a readiness probe that uses the / http endpoint
# the probe should use port 80
# the number of seconds to wait before the first probe should be 10
# the probe should execute every 5 seconds
kubectl run myreadinesspod --image=nginx --namespace chapter-03 --port=80 --dry-run=client -o yaml > myreadinesspod.yaml
# Edit myreadinesspod.yaml
# spec.containers
readinessProbe: 
    httpGet: 
        path: /
        port: 80
    initialDelaySeconds: 10
    periodSeconds: 5

kubectl create -f myreadinesspod.yaml
