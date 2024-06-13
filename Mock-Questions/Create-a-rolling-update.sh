#!/bin/bash

# Materials from https://www.youtube.com/watch?v=ADTy02AFnQo&ab_channel=TheAzureguy

# Question 1.1
# Create a deployment named deploy with 3 replicas. The pods should use the image nginx and name nginx. The deployment uses the label tier=backend. The pods should use the label app=v1
kubectl create deployment deploy --image=nginx --dry-run=client -o yaml > q11.yaml
# Edit q11.yaml 
# in metadata
labels:
    tier: backend
# in spec
replicas: 3
template:
    metadata
        labels:
            app: v1

kubectl create -f q11.yaml

# Question 1.2
# List the deployment and ensure that the correct number of replicas are running
kubectl get deployment


# Question 1.3
# Update the image to nginx:latest
kubectl set image deployment/deploy nginx=nginx:latest


# Question 1.4
# Verify the change has been rolled to all replicas
kubectl rollout history deploy
kubectl rollout history --revision=2


# Question 1.5
# Scale the deployment to 5 replicas
kubectl scale --replicas=5 -f q11.yaml


# Question 1.6
# Have a look at the deployment rollout history
kubectl rollout history deploy


# Question 1.7
# Revert the deployment to revision 1
kubectl rollout undo deployment deploy --to-revision=1


# Question 1.8
# Ensure the pods are using the image nginx
kubectl rollout history deployment deploy --revision=3