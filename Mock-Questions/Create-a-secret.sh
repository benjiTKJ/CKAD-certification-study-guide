#!/bin/bash

# Materials from https://www.youtube.com/watch?v=Mp3JyxrftsA&ab_channel=TheAzureguy

# Question 1.1
# Create a new secret named db-credentials with key/value pair db-password=speed
kubectl create secret generic db-credentials --from-literal=db-password=speed

# Question 1.2
# Create a pod named sqlsvr that uses the Secret as environment variable named DB_PASSWORD and run the container with the image=nginx
kubectl run sqlsvr --image=nginx --dry-run=client -o yaml > q3.yaml
# Edit in q3.yaml and add these lines
env:
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
        name: db-credentials
        key: db-password
kubectl create -f q3.yaml

# Question 1.3
# Shell into the pod and print out the created environment variable
kubectl exec -it sqlsvr -- env