#!/bin/bash

# Full list of kubernetes yaml config https://kubernetes.io/

# Create a namespace (called example)
kubectl create namespace example

# Get the list of namespace
kubectl get namespace

# Create yaml file (test.yaml) from command
kubectl run testPod --image=nginx:2.3.5 --port=80 --dry-run-client -o yaml > test.yaml

# Create configmap
kubectl create configmap 

# Find out kubectl yaml requirements 
kubectl explain pods.spec.containers

# Create resource from yaml file
kubectl apply -f myfile.yaml # this is more versatile as it can handle both creating and updating of resource 
# or
kubectl create -f myfile.yaml 

# Get cluster info
kubectl cluster-info

# Get nodes
kubectl get nodes