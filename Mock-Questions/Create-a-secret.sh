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

# Materials from https://www.youtube.com/watch?v=NleAoz-k79A&ab_channel=TheAzureguy
# Question 2.1
# Create a deployment with the name secretservice. Use image of Alpine
kubectl create deployment secretservice --image=alpine --dry-run=client -o yaml > q10.yaml

# Question 2.2
# Create a secret which uses 2 variables username=trixie and password=mach5. These variables must be added as a volume in the Pod
kubectl create secret generic my-secret --from-literal=username=trixie --from-literal=password=mach5
# Edit the q10.yaml
  volumeMounts:
  - name: my-secret
    mountPath: secret-vol
volumes:
  - name: secret-vol
    secret:
      secretName: my-secret

kubectl create -f q10.yaml
