#!/bin/bash

# Materials from https://www.youtube.com/watch?v=l-rq9GunyjQ&ab_channel=TheAzureguy

# Question 1.1
# Create a pod from the yaml file debugpod.yaml
cat <<EOF >> debugpod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: failing-pod
  name: failing-pod
spec:
  containers:
  - args:
    - /bin/sh
    - -c
    - while true; do echo $(date) >> ~/tmp/curr-date.txt; sleep
      5; done;
    image: busybox
    name: failing-pod
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
EOF
kubectl create -f debugpod.yaml

# Question 1.2
# Check the pod status. See any issues
kubectl get pod failing-pod


# Question 1.3
# Follow the logs to find the issue
kubectl logs failing-pod

# Question 1.4
# Fix the issue by shelling into the container. After the fix, the current date should be written to a file
kubectl exec -it failing-pod -- /bin/sh
mkdir -p ~/tmp
cd ~/tmp
