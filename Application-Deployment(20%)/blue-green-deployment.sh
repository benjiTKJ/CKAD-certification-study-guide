#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# Based on mybluedeployment.yml file create a second deployment name mygreendeployment that uses the rdiazconcha/ckad-webaapp-green:latest container image
# Create a new service mybluegreenservice for implementing the blue/green deployment strategy
# All objects should be deployed in chapter-02 namespace
kubectl create namespace chapter-02
kubectl create deployment mybluedeployment --image=rdiazconcha/ckad-webaapp-blue:latest --port=80 --replicas=5 --namespace chapter-02 --dry-run=client -o yaml > mybluedeployment.yaml
# edit mybluedeployment.yml
# Edit spec.selector.matchlabels
app: mywebapp
version: blue
# Edit spec.template.metadata.labels
app: mywebapp
version: blue

kubectl create deployment mybluedeployment --image=rdiazconcha/ckad-webaapp-green:latest --port=80 --replicas=5 --namespace chapter-02 --dry-run=client -o yaml > mygreendeployment.yaml
# edit mygreendeployment.yml
# Edit spec.selector.matchlabels
app: mywebapp
version: green
# Edit spec.template.metadata.labels
app: mywebapp
version: green

kubectl create -f mybluedeployment.yml
kubectl create -f mygreendeployment.yml

kubectl create service mybluegreenservice --namespace chapter-02 --dry-run=client -o yaml > mybluegreenservice.yml
# Edit mybluegreenservice.yml
# Edit spec.selector
app: mywebapp
version: blue
# Edit spec
ports:
- protocol: TCP
  port: 80
  targetPort: 80
type: LoadBalancer

kubectl create -f mybluegreenservice.yml