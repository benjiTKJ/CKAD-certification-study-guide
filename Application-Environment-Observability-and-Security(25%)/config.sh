#!/bin/bash

# Materials from https://www.youtube.com/watch?v=mSEsIl0EOd4&ab_channel=TheAzureguy

# Question 1.1
# Create a directory with the name config. Create 2 files in the directory.First file name db.txt and contain key value pair of password=speed. A second file name ext-service.txt with key value pair of api_key=Abc1234pl
mkdir config
cd config
cat <<EOF >> db.txt
password=speed
EOF

cat <<EOF >> ext-service.txt
api_key=Abc1234pl
EOF

# Question 1.2
# Create a secret name ext-service that uses the directory as data source and inspect the yaml representation of the object
kubectl create secret generic ext-service-secret --from-file=config
kubectl get secrets ext-service-secret -o yaml

# Question 1.3
# Create a pod name consume with the image nginx and mount the volume with mount path /var/app . Open an interactive shell and inspect the values of the secret
kubectl run consume --image=nginx --dry-run=client -o yaml > q2.yaml
# Edit q2.yaml 
    volumeMounts:
    - name: secret-vol
      mountPath: /var/app
volumes:
  - name: secret-vol
    secret:
      secretName: ext-service-service

kubectl exec consume -it -- bin/sh
cd /var/app

# Question 1.4
# Use the declarative approach to create a ConfigMap name ext-service-configmap. Use the key value pairs api_endpoint=https://myapp.com/api and username=trixie as literals
kubectl create configmap ext-service-configmap --from-literal=api_endpoint=https://myapp.com/api --from-literal=username=trixie

# Question 1.5
# Inject the configmap values into the exiting pod as environment variables
kubectl edit pod consume

env:
- name: API_ENDPOINT
  valueFrom:
    configMapKeyRef:
        name: ext-service-configmap
        key: api_endpoint
- name: USERNAME
  valueFrom:
    configMapKeyRef:
        name: ext-service-configmap
        key: username

# Question 1.6
# Open an interactive shell and inspect the values of configmap
kubectl exec consume -it -- env

# Question 1.7
# Define a security context on the container level of a new pod named security-context-demo that uses the image alpine. The security context adds the linux capability CAP_SYS_TIME to the container. Explain if the values of the security context can be redefined in a Pod level security context.
kubectl run security-context-demo --image=alpine --dry-run=client -o yaml > q7.yaml
# Edit in q7.yaml
spec:
    securityContext:
      capabilites:
        add: ["SYS_TIME"]

# Question 1.8
# Define a resourceQuota for the namespace project-corvette. The rules should constrain the count of secret objects within the namespace to 1
kubectl create namespace project-corvette
kubectl create quota my-quota --hard=secrets=1 --namespace project-corvette

# Question 1.9
# Create as many secret objects within the namespace until the max number enforced by resource quota has been reached



# Question 1.10
# Create a new service account named monitoring and assign it to a new pod with an image of your choosing. Open an interactive session and locate the authentication token of the assigned service account.
kubectl create serviceaccount monitoring
kubectl run sapod --image=busybox --dry-run=client -o yaml > q10.yaml
# Edit the q10.yaml
serviceAccountName: monitoring

kubectl create -f q10.yaml
kubectl exec sapod --it -- bin/sh
cd var/run/secrets/kubernetes.io/serviceaccount
cat token


