#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Completions: the number of times a job needs to run successfully to be considered completed

# backoffLimit: number of times kubernetes will retry a job if it fails

# ttlSecondsAfterFinish: sets the lifetime of a job after its finished (if want the pod deleted after its done)

# Parallelism: number of pods that can run simultaneously

# Task 
# Create a job named myjob in the ns chapter-01 based on the busybox image. It should output CKAD and sleep for 10 seconds
# The job should retry 6 times, and delete the pods after 10 seconds
# The job needs to run 2 times to be considered complete
# Only one pod should run at a time
kubectl create namespace chapter-01
kubectl create job myjob --image=busybox --dry-run=client -o yaml > myjob.yaml
# Edit myjob.yaml
# under spec.containers.image
command: ["sh","-c","echo 'CKAD' && sleep 10"]
# under spec
backoffLimit: 6
completions: 2
parallelism: 1
ttlSecondsAfterFinished: 10

kubectl create -f myjob.yaml


