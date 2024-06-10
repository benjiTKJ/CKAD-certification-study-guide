#!/bin/bash

# Materials from https://www.youtube.com/watch?v=NuyrWrIW91I&ab_channel=TheAzureguy

# Question 1.1
# Create a pod named secrured that uses the image nginx. Mount an emptyDir volume to the directory /data/app
kubectl run secured --image=nginx --dry-run=client -o yaml > q4.yaml
# Edit in q4.yaml
spec:
    securityContext:
        fsGroup: 3000
    volumes:
    - name: data-vol
      emptyDir: {}
    containers:
    - image: nginx
      name: secured
      volumeMounts:
        - name: data-vol
          mountPath: /data/app
kubectl create -f q4.yaml

# Question 1.2
# Files created on the volume should use the filesystem group ID 3000


# Question 1.3
# Shell into the running container and create a new file named logs.txt in the directory /data/app List the contents of the directory and write down
kubectl exec secured -it -- bin/sh 
cd data/app
touch logs.txt
ls -la 