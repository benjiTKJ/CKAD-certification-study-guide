#!/bin/bash

# Materials from https://www.youtube.com/watch?v=0-tjtenw5xI&ab_channel=TheAzureguy

# Question 1.1
# Create a CronJob named show-date that runs every minute and executes the shell command echo "Current date: $(date)"
kubectl create cronjob show-date --image=busybox --schedule="*/1 * * * *" -- /bin/sh -c 'echo "Current date $(date)"'


# Question 1.2
# Watch the jobs as they are being scheduled
kubectl get cronjob --watch


# Question 1.3
# Identify one of the pods that ran the CronJobs and render the logs
kubectl logs podname


# Question 1.4
# Determine the number of successful executions the CronJob will keep in its history 
kubectl get cronjobs show-date -o yaml 


# Question 1.5
# Delete the CronJob
kubectl delete cronjob show-date