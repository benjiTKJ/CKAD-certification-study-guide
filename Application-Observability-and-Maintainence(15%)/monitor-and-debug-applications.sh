#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# commands: 
kubectl top # provide real time resource usage statistics for nodes and pods
kubectl get events
kubectl logs
kubectl exec
kubectl describe 

# Task
# The pod myfailingpod is failing. Identify the issue and solve it
kubectl describe pod myfailingpod
kubectl edit pod myfailingpod
# remove the command