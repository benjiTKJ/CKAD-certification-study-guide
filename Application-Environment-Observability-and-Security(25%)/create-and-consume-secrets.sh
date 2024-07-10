#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# Create a new secret mysecret in the chapter-04 namespace and add the exam key with CKAD as the value
# Create a new pod mysecretpod that uses nginx image
# Add the environment variable MY_EXAM_ENV that read the value of exam from mysecret
kubectl create secret generic mysecret --from-literal=exam=CKAD --namespace chapter-04 
kubectl run mysecretpod --image=nginx --namespace=chapter-04 --dry-run=client -o yaml > mysecretpod.yaml
# Edit mysecretpod.yaml
# spec.containers
env:
- name: MY_EXAM_ENV
valueFrom: 
    secretKeyRef:
        name: mysecret
        key: exam
        
kubectl apply -f mysecretpod.yaml