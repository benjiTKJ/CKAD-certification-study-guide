#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# You have the following pods in the namespace chapter-05 - pod-a pod-b mypod
# Modify the existing network policies named mynetpol to ensure that mypod allows traffic only to and from pod-a and pod-b
kubectl get networkpolicy
kubectl describe networkpolicy mynetpol
kubectl edit networkpolicy mynetpol
# spec
ingress: 
- from:
  - podSelector: 
      matchLabels: 
        app: pod-a
  - podSelector:
      matchLabels:
        app: pod-b
egress:
- to:
  - podSelector:
      matchLabels: 
        app: pod-a
  - podSelector:
      matchLabels: 
        app: pod-b