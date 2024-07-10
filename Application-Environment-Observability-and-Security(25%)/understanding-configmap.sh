#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# Create a new configmap myconfigmap in the chapter-04 namespace and add the exam key with CKAD as the value
# Create a new pod myconfigmappod with nginx image
# Add the environment variable name MY_EXAM_ENV that reads the value of exam from myconfigmap
kubectl create configmap --from-literal=exam=CKAD --namespace chapter-04
kubectl run myconfigmappod --image=nginx --dry-run=client -o yaml > myconfigmappod.yaml
# Edit myconfigmappod.yaml
# spec.containers
env:
- name: MY_EXAM_ENV
valueFrom: 
    configMapKeyRef:
        name: myconfigmap
        key: exam
        
kubectl apply -f myconfigmappod.yaml