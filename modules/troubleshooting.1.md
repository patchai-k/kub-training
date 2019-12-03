# Troubleshooting

## Module Objectives

-  Practice troubleshooting with Kubernetes 
---

## `IMPORTANT SETUP`
Run the following to create Kubernetes objects that contain errors:


```shell
~/kubernetes-training/starting-points/start.sh trouble
```

## The app

When working correctly, you will be able to
browse to a web server, a list of locations
will be shown, and you will have the ability to add a new
location by clicking a button.  When you add a location it adds
the location to the database and lists the updated list of
locations.

## The Architecture

There is a front end app named "web":
  - It is a web server that lists locations from the `/locations` URL.
  - It has the ability to add a new location from the URL `/location/new/`
  - A Kubernetes LoadBalancer service listens on port 80 and
    connects to the web server on port 5000.
  - The web front end listens on port 5000.
  - The web front end connects to a database on localhost port 54320.

A sidecar container:
  - Is named "dbproxy" and is part of the "web" pod.
    `dbproxy` listens on localhost port 54320 and connects to the
    database on the hostname/service named ``db``.

A database:
  - Runs in a separate pod.
  - Listens on port 5432.

The correct web front end app docker image is: `gcr.io/timf-gcp-404004/web:2.4`

The correct `dbproxy` docker image is: `gcr.io/timf-gcp-404004/dbproxy:5.1`

## There are some issues

The `db` deployment and service work with no issues.
Consider those a working black box for this exercise.

However, the web app is a different story:  When you start the
deployment, you will see the app has a number of issues that
require troubleshooting and fixing before they will work.

## The Goal
The goal is to be able to browse to the web app, add 3 additional
locations and make sure the app stays running for more than 3 minutes
without restarting (check the `RESTARTS` column from `kubectl get
pods`).

## Troubleshooting
Some commands you may want to use for troubleshooting:

   ```
kubectl get deployment DEPLOYMENT-NAME  -o yaml > deployment-name.yaml
kubectl get pods
kubectl get deployments
kubectl describe pod ...
kubectl edit deployment ...
kubectl get deployment <deployment-name> -o yaml
kubectl get services
kubectl describe services
kubectl logs <pod-name>
kubectl logs <pod-name> -c <container-name>
kubectl exec -it <pod-name> -c <container-name> bash
   ```

**For pods and deployments:** Use the `kubectl describe` command and look
at `Events`.

**For services:** check `endpoints` to see the IP addresses where services
are being routed.

You probably want to look at the yaml to help you find the errors
more easily.

You will *not* need to change the `db` deployment or service:
They work.

## **IMPORTANT CLEANUP**
Run the following to cleanup your environment

```shell
~/kubernetes-training/starting-points/cleanup.sh trouble
```
