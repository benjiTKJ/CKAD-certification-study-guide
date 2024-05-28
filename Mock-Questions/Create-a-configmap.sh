#!/bin/bash

# Materials from https://www.youtube.com/watch?v=0Q_Qv9Pw-qk&ab_channel=TheAzureguy

cat <<EOF >> config.txt
DB_URL=localhost:1433
DB_USERNAME=speed
EOF

# Question 1.1
# Create a configmap named db-config from the file config.txt above
kubectl create configmap db-config --from-env-file=config.txt

# Question 1.2
# Create a pod named sqlsvr that used the environment variables from the configmap and runs a container with image nginx
kubectl run sqlsvr --image=nginx --dry-run=client -o yaml > q2.yaml
# Edit in q2.yaml and add these lines below under spec.container
envFrom:
-  configMapRef:
        name: db-config

kubectl create -f q2.yaml

# Question 1.3
# Shell into the pod and print out the created environment variable
kubectl exec -it sqlsvr -- env