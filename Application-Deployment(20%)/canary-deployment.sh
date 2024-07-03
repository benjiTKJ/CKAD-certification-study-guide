#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# Modify the existing deployment files
# A maximum of 5 pods should be running at a time
# Canary must recieve 20% of the traffic
# Fix the selector in the service
kubectl create deployment mystabledeployment --image=rdiazconcha/ckad-webapp-blue:latest --port=80 --namespace chapter-02 --dry-run=client -o yaml > mystabledeployment.yaml
# Edit mystabledeploy.yaml
# spec
replicas: 4
selector:
    matchlabels:
        app: mywebapp
        version: stable
# spec.template.metadata
labels:
    app: mywebapp
    version: stable

kubectl create deployment mycanarydeployment --image=rdiazconcha/ckad-webapp-green:latest --port=80 --namespace chapter-02 --dry-run=client -o yaml > mycanarydeployment.yaml
# Edit mycanarydeployment.yaml
# spec
replicas: 1
selector:
    matchlabels:
        app: mywebapp
        version: canary
# spec.template.metadata
labels:
    app: mywebapp
    version: canary

kubectl create service mycanaryservice --dry-run=client -o yaml > mycanaryservice.yaml
# Edit mycanaryservice.yaml
# spec
selector: 
    app: mywebapp
ports:
- protocol: TCP
  port: 80
  targetPort: 80 
type: LoadBalancer

kubectl create -f mystabledeployment.yaml
kubectl create -f mycanarydeployment.yaml
kubectl create -f mycanaryservice.yaml

