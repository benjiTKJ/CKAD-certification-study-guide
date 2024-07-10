#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# The application in myserviceaccounts deployment located in namespace chapter-04 is not working as expected
kubectl get all
kubectl edit deployment myserviceaccounts
# change the service account from sa1 to mysa, as sa1 does not have the rolebinding
