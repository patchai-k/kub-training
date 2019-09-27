#!/bin/sh

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
