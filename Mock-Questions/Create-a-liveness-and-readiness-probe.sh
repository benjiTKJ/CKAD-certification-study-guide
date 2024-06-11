#!/bin/bash

# Materials from https://www.youtube.com/watch?v=_RA49dQadyg&ab_channel=TheAzureguy

# Question 1.1
# Create a pod named hello with the image speedracer5dave/nodejs-hello-world that exposes the port 3000. Name the port nodejs-port
kubectl run hello --image=speedracer5dave/nodejs-hello-world --port=3000 --dry-run=client -o yaml > q7.yaml
# Edit q7.yaml and add below
ports: 
- containerPort: 3000
  name: nodejs-port


# Question 1.2
# Add a readiness probe that checks the url path / on the port with the name above after a 2 second delay
# Edit q7.yaml and add below
readinessProbe: 
  httpGet:
    path: /
    port: nodejs-port
  initialDelaySeconds: 2


# Question 1.3
# Add a liveness probe that verifies the app is running every 8 seconds by checking the url path / on the port referenced with nodejs-port. The probe should start with a 5 second delay
# Edit q7.yaml and add below
livenessProbe:
  httpGet:
    path: /
    port: nodejs-port
  periodSeconds: 8
  initialDelaySeconds: 5

kubectl create -f q7.yaml

# Question 1.4
# Shell into the container and curl localhost:3000. Note the message. Retrieve the logs from the container
kubectl exec -it hello -- /bin/sh
curl localhost:3000
