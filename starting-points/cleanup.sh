#!/bin/bash

cd `dirname "$0"`
lab_name=$1

#TODO: change repo dir to something more exact
repo_dir=..

# Check for lab name
if [ -z ${lab_name} ]; then
  echo "Please supply a lab name"
  echo "Usage: clean.sh [lab name]"
  exit 1
fi

# Backup current work directory
mkdir -p $repo_dir/workspace_backup/${lab_name}/workspace
# TODO: let this fail gracefully when workspace dir is empty
mv -f $repo_dir/workspace/* $repo_dir/workspace_backup/${lab_name}/workspace
mkdir -p $repo_dir/workspace

# backup kubernetes objects
kubectl get all -o yaml > $repo_dir/workspace_backup/$lab_name/_k8s_object_backup.yaml

# Clean up all k8s objects
objects=(hpa networkpolicy deployments replicasets statefulsets daemonsets jobs pods secrets configmaps persistentvolumeclaim persistentvolume)
echo ""
echo "This will delete objects in the current namespace"
echo "Use this script with caution!"
echo ""
echo "Deleting:"
for obj in ${objects[@]}; do
  echo "* $obj"
  kubectl delete $obj --all --now
done

echo "* services - all non-LoadBalancer services"
# get list of all service names
services=( $(kubectl get services -o jsonpath='{.items[*].metadata.name}') )

# delete if not LoadBalancer
for svc in ${services[@]}; do
  type=$(kubectl get service $svc -o jsonpath='{.spec.type}')
  if [ "$type" != "LoadBalancer" ]; then
    kubectl delete service $svc
  fi
done
