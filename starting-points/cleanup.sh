#!/bin/sh

cd `dirname "$0"`
lab_name=$1

#todo: change workspace dir to something more exact
repo_dir=../

# Check for lab name
if [ -z ${lab_name} ]; then
  echo "Please supply a lab name"
  echo "Usage: clean.sh [lab name]"
  exit 1
fi

# Backup current work directory
set -ex
mkdir -p $repo_dir/workspace_backup/$lab_name
mv -rf $repo_dir/workspace $repo_dir/workspace_backup/$lab_name
mkdir -p $repo_dir/workspace
set +ex

# backup kubernetes objects
kubectl get all > $repo_dir/workspace_backup/$lab_name/_k8s_object_backup.yaml

# Clean up all k8s objects
objects=(hpa ingress services networkpolicy deployments replicasets statefulsets daemonsets jobs pods secrets configmaps persistentvolumeclaim persistentvolume)
echo ""
echo "This will delete ALL of the following kubernetes objects in the user's namespace:"
for obj in ${objects[@]}; do
  echo "* $obj"
done
echo ""
echo "Use this script with caution!"
echo ""


for obj in ${objects[@]}; do
  set -x
  kubectl delete $obj --all --now
  set +x
done
