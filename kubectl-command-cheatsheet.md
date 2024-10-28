Full list of [kubectl commands](https://kubernetes.io/docs/reference/kubectl/quick-reference/) 

List of commonly used kubectl commands that helped me in the exam:

# Pods

1) Create pods
* Creates a pod called sample, with image nginx:alpine with label id:sample and run the command sleep 3600
```sh
kubectl run sample --image=nginx:alpine --labels=id=sample -- sleep 3600
```

2) List pods with ip address
* List all pods in namespace sample with ip address
```sh
kubectl get pods -n sample -o wide
```

3) List pods and their labels
* List all pods in namespace test with their labels
```sh
kubectl get pods -n test --show-labels
```

4) Delete pods
```sh
kubectl delete pod this-sample-pod 
```

* During the test it would be better to use with --force to delete immediately
```sh
kubectl delete pod this-sample-pod --force
```

# Deployment

1) Create deployment
```sh
kubectl create deploy sample -n alpha --image=nginx:alpine --replicas=1 
```

# Service

1) Create service 
* Create a clusterip called sample-service exposing port 80 to target port 80
```sh
kubectl create svc clusterip sample-service --tcp=80:80
```


2) Create service from deployment
* Create a service from deployment sample-deploy in the beta namespace called sample-svc with type Cluster IP
```sh
kubectl expose deploy -n beta sample-deploy --name=sample-svc --type=ClusterIP --port=80
```

3) Create a service from pod
* Create a service from pod test-pod in the charlie namespace called test-svc with type Node Port
```sh
kubectl expose pod -n charlie test-pod --name=test-svc --type=NodePort --port=80
```

* If the requirement is to specify the NodePort's port explictly (eg 30007), you will need to edit in the yaml config file
```sh
kubectl expose pod -n charlie test-pod --name=test-svc --type=NodePort --port=80 --dry-run=client -o yaml > test-svc.yaml

vi test-svc.yaml

# test-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: test-svc
spec:
  type: NodePort
  selector:
    app.kubernetes.io/name: test-pod
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30007  # ADD THIS
```

# Namespace 

1) Create namespace
```sh
kubectl create ns example
```

2) Get all the namespaces
```sh
kubectl get namespace
```

# Config Map

1) Create configmap from string
```sh
kubectl create cm sample --from-literal=key=value
```

2) Create configmap from file
```sh
kubectl create cm sample --from-file=file.txt
```

* Also can add a key to the file
```sh
kubectl create cm sample --from-file=key=file.txt
```

# Secret

1) Create secret from string
* Create a secret called sample-secret with key=value
```sh
kubectl create secret generic sample-secret --from-literal=key=value
```

2) Create a secret from file
* Create a secret called test-secret using the values from sample.txt
```sh
kubectl create secret generic test-secret --from-file=sample.txt
```

# Nodes

1) Get nodes
```sh
kubectl get nodes
```

2) Get CPU & Mem
```sh 
kubectl top nodes
```

3) Describe nodes
* Can use this to check the node taint, labels for pod toleration or selections
```sh
kubectl describe node contolplane 
```

# Labels & Annotations

1) Label pods 
* Label pod sample-pod with this:label
```sh
kubectl label pod sample-pod this=label
```

2) Label pods in deployment 
* Label pods in deployment test-deploy with id=sample-pods
```sh
kubectl label deploy test-deploy id=sample-pods
```

3) Label pods that have a certain label
* Label pod only with the label id:label-me with a new label hello:world
```sh
kubectl label pod -l id=label-me hello=world
```

4) Delete label 
* Delete the label id=pod from the pod sample-pod
```sh
kubectl label pod sample-pod id-
```

5) Annotate pod
* Annotate the pod beta-pod with description "This is a sample description"
```sh
kubectl annotate pod beta-pod description="This is a sample description"
```

* Annotate the pods which has the label id=label-me with description "Do not delete me"
```sh
kubectl annotate -l id=label-me description="Do not delete me"
```

# Others

1) Output imperative commands into yaml file to edit
```sh
--dry-run=client -o yaml > sample.yaml
```

2) Explain command to check the config
* List down possible values of pod.spec
```sh
kubectl explain pod.spec
```

* You can go further deeper into the config eg
```sh
kubectl explain pods.spec.containers
```

3) Create resource from yaml file
* It is recommended to use apply as compared to create as apply can handle both creating and updating of resource
```sh
kubectl apply -f myfile.yaml

# or 

kubectl create -f myfile.yaml 
```

4) Get cluster info 
```sh
kubectl cluster-info
```

5) Edit any kubernetes resource
* Edit can be used for most resources, and not only for the below mentioned ones
* Do note that sometimes certain resources like pods cannot be edited when its running, hence it will create a temporary file of the edited resource, and you will need to delete the pod and recreate it again with the updated configuration
```sh
# Pod
kubectl edit pod sample-pod

# Deployment
kubectl edit deploy sample-deploy

# Service
kubectl edit svc sample-service

# Config Map
kubectl edit cm sample-configmap
```