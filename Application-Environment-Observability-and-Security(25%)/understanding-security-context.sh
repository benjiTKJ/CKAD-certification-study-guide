#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# runAsUser & runAsGroup - allow you to specify the userId and groupId under which the container process will run respectively 
# allowPrivilegeEscalation - determines whether a process within a container can gain additional privileges beyond its initial set
# privileged - controls whether a container has access to all the capabilities of the host system

# Task
# Modify the existing mysecuritycontext deployment in namespace chapter-04. The container should run with userId 2000 groupId 3000, and no privilege escalation
kubectl create deployment mysecuritycontext --image=redis --namespace chapter-04
kubectl edit deployment mysecuritycontext
# spec.template.spec.containers
securityContext:
  runAsUser: 2000
  runAsGroup: 3000
  allowPrivilegeEscalation: false 
