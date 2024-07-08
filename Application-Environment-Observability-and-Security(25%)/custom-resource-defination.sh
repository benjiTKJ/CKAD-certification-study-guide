#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# Custom resource defination - CRD - feature to extend kubernetes functionality by defining and adding custom resource to the API which can be treated just like built-in objects 

# Task
# Deploy custom resource defination in the mypetcrd.yaml file
# Deploy a new pet object by applying the mypet.yaml file

cat<<EOF >> mypetcrd.yaml 
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: pets.wisdompetmed.com
spec:
  group: wisdompetmed.com
  versions:
  - name: v1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              breed:
                type: string
              name:
                type: string
    scope: Namespaced
    names:
        plural: pets
        singular: pet
        kind: Pet
        shortNames: 
          - pt
EOF
kubectl apply -f mypetcrd.yaml 

# list the api resources
kubectl api-resources

cat<<EOF >> mypet.yaml
apiVersion: wisdompetmed.com/v1
kind: Pet
metadata:
  name: mypet
spec:
  breed: Beagle
  name: Gianni
EOF

kubectl apply -f mypet.yaml