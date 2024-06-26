#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Design patterns

# initContainers: run before the main containers in a pod
# sidecar, adapter, ambassador: extend the main functionality of the main container

# Task
# Fix the failing pod named mymulticontainerpod deployed in the chapter-01 namespace
kubectl describe pod mymulticontainerpod --namespace chapter-01
kubectl edit pod mymulticontainerpod
# fix the command 