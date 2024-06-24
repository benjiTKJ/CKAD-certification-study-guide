#!/bin/bash

# Materials from https://www.youtube.com/watch?v=UYj_J3JaOOw&ab_channel=TheAzureguy

# Question 1.1
# Create a yaml manifest for a pod named complex-pod. The main application container name app should use the image nginx and expose the container port 80. Modify the YAML manifest so that the pod defines an init container named setup that uses the image busybox. The init container run the command wget -O- google.com
kubectl run complex-pod --image=nginx --port=80 --dry-run=client -o yaml > q1.yaml
# edit q1.yaml
- image: nginx
  name: app
  ports:
  - containerPort: 80
initContainers:
- image: busybox
  name: setup
  command: ["sh","-c","wget -O- google.com"]

# Question 1.2
# Create the pod from the yaml manifest
kubectl create -f q1.yaml

# Question 1.3
# Download the logs of the init container. You should see the output of the wget command
kubectl logs complex-pod -c setup

# Question 1.4
# open an interactive shell to the main application container and run the ls command. Exit out of the container
kubectl exec -it app sh
ls -la
exit


# Question 1.5
# force delete the od
kubectl delete pod complex-pod --force --timeout=0

# Question 1.6
# Create a yaml manifest named data-exchange. The main application container named main-app should use the image busybox. The container runs a command that writes a new file every 30 seconds in an infinte loop in the directory /var/app/data. The filename follows the pattern {counter ++}-data.txt. The variable counter is incremented every interval and starts with the value 1
kubectl run data-exchange --image=busybox --dry-run=client -o yaml > q6.yaml
# Edit the q6.yaml
- image: busybox
  name: main-app
  command: ["sh","-c",'counter=1; while true; do touch "/var/app/data/$counter-data.ext"; counter=$((counter+1)); sleep 30; done']


# Question 1.7
# Modify the YAML manifest by adding  a sidecar named sidecar. The sidecar containers uses the image of busybox and runs a command that counts the number of files produced by the main-app container every 30 secs in an infinite loop. The command writes the number of files to standard output
- image: busybox
  name: sidecar
  command: ['sh','-c','while true; do ls -d /var/app/data/*-data.ext | wc -l; sleep 30; done']

# Question 1.8
# Define a volume of type emptydir. Mount the path /var/app/data for both containers
# volume defined for main-app
volumes:
- name: shared-vol
  mountPath: /var/app/data

# volume defined for sidecar
volumes:
- name: shared-vol
  mountPath: /var/app/data

# shared volume
volumes:
- name: shared-vol
  emptyDir: {} 


# Question 1.9
# Create the pod. Tail the logs of the sidecar container
kubectl logs data-exchange -c sidecar -f

# Question 1.10
# Delete the pod
kubectl delete pod data-exchange