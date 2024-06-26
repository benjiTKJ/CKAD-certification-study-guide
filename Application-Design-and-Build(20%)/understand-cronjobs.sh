#!/bin/bash

# Materials from https://www.linkedin.com/learning/certified-kubernetes-application-developer-ckad-exam-tips/understand-jobs?autoSkip=true&resume=false&u=109812938

# schedule: cron expression

# jobTemplate: template of the job object

# Task
# Create a cronJob named mycronjob in the namespace chapter-01 based on the busybox image. It should output CKAD
# The cronjob should delete the pods after 10 seconds
# The job needs to run 2 times to be considered complete
# The cronjob should run every 2 minutes
kubectl create cronjob mycronjob --image=busybox --schedule="*/2 * * * *" --dry-run=client -o yaml > mycronjob.yaml
# edit the mycronjob.yaml file
# Edit spec.jobTemplate.spec.template.spec.containers
command: 
- /bin/sh
- -c
- echo 'CKAD'
# Edit spec.jobTemplate.spec
ttlSecondsAfterFinished: 10
completions: 2
