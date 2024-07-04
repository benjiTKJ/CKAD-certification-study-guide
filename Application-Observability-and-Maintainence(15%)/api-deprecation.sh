#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# kubectl-convert - convert manifest file for an older version of k8s to a recent one
# Need to install the kubectl convert plugin

# Task
# mydeprecated-deployment.yaml file contains a deployment created for an older version of k8s
# convert the existing deployment file so it can be used in a newer version of k8s
kubectl create deployment mydeprecated-deployment --replicas=3 --image=nginx --port=80 --dry-run=client -o yaml > mydeprecated-deployment.yaml
# edit the k8s version to an older one
apiVersion: extensions/v1beta1

kubectl convert -f mydeprecated-deployment --output-version apps/v1 > myupdated-deployment.yaml