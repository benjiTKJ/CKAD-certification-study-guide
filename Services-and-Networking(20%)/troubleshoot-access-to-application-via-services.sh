#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# The service myfailingservice located in the chapter-05 namespace should use the Pods created by mydeployment
# the service is not behaving correctly. Identify the problem and fix it
kubectl describe service myfailingservice
kubectl edit service myfailingservice
# change the selector name
selector:
  app: mydeployment