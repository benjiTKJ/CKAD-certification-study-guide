#!/bin/bash

# Materials from https://www.youtube.com/watch?v=y9miRyLRTA0&ab_channel=TheAzureguy

# Question 1.1
# Create a namespace app-stack
kubectl create namespace app-stack

# Question 1.2
# Retrieve the pod defination https://github.com/speedracer55/ckad-files/blob/main/networkp.yaml


# Question 1.3
# Create a network policy yaml file
cat <<EOF >> networkpolicy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: app-stack-network-policy
  namespace: app-stack
spec:
  podSelector:
    matchLabels:
      app: todo
      tier: database
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: todo
          tier: backend
    ports:
    - protocol: TCP
      port: 3306
EOF
kubectl create -f networkpolicy.yaml
kubectl get networkpolicies --namespace app-stack

# Question 1.4
# The network policy should allow incoming traffic from the backend to database but disallow incoming traffic from the frontend
kubectl run test --image=busybox --restarty=Never --labels="app=todo,tier=backend" --namespace app-stack --rm -it sh
wget -O- ip-address-of-database:3306
kubectl run test1 --image=busybox --restarty=Never --labels="app=todo,tier=frontend" --namespace app-stack --rm -it sh
wget -O- ip-address-of-database:3306

# Question 1.5
# Incoming traffic to the database should only be allowed on TCP port 3306