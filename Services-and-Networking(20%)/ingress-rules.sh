#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Task
# Create an ingress for wisdompetmed.com host that maps the /pets prefix to a service named myservice using port 80
kubectl create ingress myingress --namespace chapter-05 --dry-run=client -o yaml > myingress.yaml
# Edit myingress.yaml 
spec:
  rules:
  - hosts: wisdompetmed.com
    http:
      paths: 
      - path: /pets
        pathType: Prefix
        backend:
          service: 
            name: myservice
            port: 
              number: 80 