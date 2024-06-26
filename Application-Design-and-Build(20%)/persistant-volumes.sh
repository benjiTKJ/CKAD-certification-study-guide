#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# PV represent physical volume in a cluster independent of pod lifecycle.

# PVC are request for storage by pods

# Task
# Configure the pod named mypvpod to use the mypvc persistent volume claim
kubectl create pvc mypvc --dry-run=client  -o yaml > mypvc.yml
# Edit mypvc.yml
spec:
    accessModes:
        - ReadWriteOnce
    resources: 
      requests:
        storage: 100Mi
    storageClassName: managed-csi

kubectl create -f mypvc.yml

kubectl run mypvpod --image=busybox --dry-run=client -o yaml > mypvpod.yml
# Edit mypvpod.yml
# Edit spec.containers
command: ["sh","-c","echo 'CKAD' > /data/file.txt && sleep 300"]
volumeMounts:
    - name: myvolume
      mountPath: "/data"
# Edit spec
volumes: 
- name: myvolume
  persistentVolumeClaim: 
    claimName: mypvc

kubectl create -f mypvpod.yml