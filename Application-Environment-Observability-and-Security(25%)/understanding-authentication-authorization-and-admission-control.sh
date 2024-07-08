#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Service account - authenticate and identify individual applications or processes
# RBAC - authorization method that grants permission to users, groups or service accounts based on the roles
# Admission control - a phase during the API request, either built in or dynamic admission control

# Task
# Create a new service account mysa
# Create a rolebinding for viewing objects and apply it to mysa
# Create a new pod that uses the mysa Service account and automatically mounts a token volume
# Use the token to query the Kubernetes API and view all the pods

kubectl create serviceaccount mysa
kubectl create rolebinding mysa-view --cluster-role=view --serviceaccount=chapter-04:mysa
kubectl run mytokenpod --image=nginx --dry-run=client -o yaml > mytokenpod.yaml
# Edit mytokenpod.yaml
# spec
serviceAccountName: mysa   

volumes:
- name: myvolume
  projected:
    sources:
    - serviceAccountToken:
        path: token

# spec.containers
volumeMounts:
- name: myvolume
  mountPath: /secrets 

kubectl apply -f mytokenpod.yaml
kubectl exec -it mytokenpod -- sh
cd secrets
ls
cat token
TOKEN=$(cat secrets/token)
curl -k -H "Authorization: Bearer $TOKEN" cluster-api-url