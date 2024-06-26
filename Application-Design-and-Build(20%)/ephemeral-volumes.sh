#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# Create a pod named myevpod that mounts an ephemeral volume of type emptyDir in the /data path
# All objects should be deployed into chapter-01 namespace
kubectl run myevpod --image=busybox --namespace chapter-01 --dry-run=client -o yaml > myemphermeral.yml
# Edit myemphermeral.yml
# Edit spec.containers
command: ["sh","-c","while true; do echo 'Hello CKAD' >> /data/message.txt; sleep 5; done"]
volumeMounts: 
- name: myvolume
  mountPath: /data

# Edit spec
volumes:
- name: myvolume
  emptyDir: {}

kubectl create -f myemphermeral.yml