#!/bin/bash

# Materials from https://youtube.com/watch?v=DBVjTZIgZ-w&ab_channel=TheAzureguy

# Question 1.1
# Create a resource quota named app under the namespace rq-demo. Use a file name rq.yaml
kubectl create quota app --hard=cpu=1,memory=500m,pods=2 --namespace=rq-demo --dry-run=client -o yaml > rq.yaml
kubectl create -f rq.yaml

# Question 1.2
# Create a new pod that extends the limits of the resource quota be defining 1G of memory. Note the error
kubectl run highpod --image=nginx --namespace=rq-demo --dry-run=client -o yaml > q5.yaml
# Edit the file q5.yaml
resources:
    requests:
        memory: "1G"
        cpu: "500m"

# Question 1.3
# Change the request limits to fulfil the requirements to ensure that the pod can be created successfully
# Edit the file q5.yaml
resources:
    requests:
        memory: "500m"
        cpu: "500m"