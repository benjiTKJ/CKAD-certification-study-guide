#!/bin/bash

# Materials from https://www.youtube.com/watch?v=7b_qIP9YCmc&ab_channel=TheAzureguy

# Question 1.1
# Init container retrieves configuration files from  a remote location and makes it available to the application running in the main container. The configuration files are shared through a volume mounted by both container
# Create a new pod in a yaml file named business-app.yaml. The pod should define 2 container configurer and the main container web. The init container uses the image busybox, the main container uses the image speedracer5dave/nodejs-read-config:latest Expose the main container on port 8080
kubectl run newpod --image=speedracer5dave/nodejs-read-config:latest --port=8080 --dry-run=client -o yaml > business-app.yaml
# Update business-app.yaml with initContainers
initContainers:
- name: configurer
  image: busybox


# Question 1.2
# Edit the yaml file by adding a new volume of type emptyDir mounted as /user/shared/app for both containers
volumes:
- name: shared-vol
  emptyDir: {}

#below init containers
    volumeMounts:
    - mountPath: /user/shared/app
    name: shared-vol

#below containers
    volumeMounts:
    - mountPath: /user/shared/app
      name: shared-vol

# Question 1.3
# Edit the yaml file by providing the command for the init container. The init container should run  a wget command for  downloading the file https://github.com/speedracer55/ckad-crash-course/blob/master/exercises/07-creating-init-container/app/config/config.json into the directory /usr/shared/app
command: 
- wget
- "-O"
- "/user/shared/app/config.json"
- https://github.com/speedracer55/ckad-crash-course/blob/master/exercises/07-creating-init-container/app/config/config.json

# Question 1.4
# Start the pod and verify init container started and terminated, the web container is running and volumes are mounted
kubectl create -f business-app.yaml
kubectl describe pod newpod

# Question 1.5
# Run the command curl localhost:8080 from the main application container. The response should render a database url derived off the config file
kubectl exec newpod -it -- bin/sh
curl localhost:8080 