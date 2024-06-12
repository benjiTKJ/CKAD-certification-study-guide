#!/bin/bash

# Materials from https://www.youtube.com/watch?v=dTazqRw7D7A&ab_channel=TheAzureguy

# Question 1.1
# Create 3 different pod with names of web, batch, and database and use the image of nginx
kubectl run web --image=nginx --labels="env=prod,tier=web"
kubectl run batch --image=nginx --labels="env=prod,tier=batch"
kubectl run database --image=nginx --labels="env=prod,tier=database"


# Question 1.2
# Declare labels for the pods as follows: 
# Web -env=prod, tier=web
# batch -env=prod, tier=batch
# database -env=prod, tier=database


# Question 1.3
# List the pods and their labels
kubectl get pods --show-labels

# Question 1.4
# Use label selectors to query for all production belonging to web and batch
kubectl get pods -l 'env in (prod), tier in (web,batch)'

# Question 1.5
# Remove the label tier from the database pod
kubectl label pod database tier-
