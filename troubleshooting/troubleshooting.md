# Troubleshooting

## Module Objectives

-  Practice troubleshooting with Kubernetes 
---

## The app

When working correctly, you will be able to
browse to a web server, a list of locations
will be shown, and you will have the ability to add a new
location by clicking a button.  When you add a location it adds
the location to the database and lists the updated list of
locations.

## The Architecture

There is a front end app named "web":
  - It is a web server that lists locations from the **/locations** URL.
  - It has the ability to add a new location from the URL **/location/new/**
  - The web front end connects to a database on localhost port 54320.
  - The web front end listens on port 5000.
  - A Kubernetes LoadBalancer service listens on port 80 and
    connects to the web server on port 5000.

A database:
  - Runs in a separate pod.
  - Listens on port 5432.

A sidecar container:
  - Is named "dbproxy" and is required with the "web" pod.
    **dbproxy** listens on localhost port 54320 and connects to the
    database on the hostname/service named **db**.  In other words,
    the web server connects to the database by connecting to localhost
    on port 54320 and the sidecar proxy forwards that connection to the
    **db** service on port 5432.

The web front end app image is: **gcr.io/timf-gcp-404004/web:2.4**

The **dbproxy** docker image is: **gcr.io/timf-gcp-404004/dbproxy:5.1**

## There are some issues

The **db** deployment and service work with no issues.
Consider those a working black box for this exercise.

However, the web app is a different story:  When you start the
deployment, you will see the app has a number of issues that
require troubleshooting and fixing before they will work.

## The Goal
The goal is to be able to browse to the web app, add 3 additional
locations and make sure the app stays running for more than 3 minutes
without restarting (check the **RESTARTS** column from **kubectl get
pods**).

## Troubleshooting
Some commands you may want to use for troubleshooting:

   ```shell
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

For pods and deployments, use the **kubectl describe** command and look
at **Events**.  For services, check endpoints to see the IP addresses
where services are being routed.

You probably want to look at the yaml to help fix errors.

You will *not* need to change the **db** deployment or service:
They work.

## Getting started
Make sure you have pulled the latest version from the git repo.
Then **cd** to the **troubleshooting/trouble** directory and launch it all:

   ```shell
git pull
cd troubleshooting/trouble
kubectl apply -f .
   ```
