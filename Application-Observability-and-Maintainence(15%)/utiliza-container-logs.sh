#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# Create a new pod named mylogspod that uses the rdiazconcha/ckad-worker:latest container image
# This pod must be created in the chapter-03 namespace
# Save the container logs in the logs.txt file in your home folder
kubectl run mylogspod --image=rdiazconcha/ckad-worker:latest --namespace chapter-03
kubectl logs mylogspod > logs.txt