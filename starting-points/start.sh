#!/bin/bash

cd `dirname "$0"`
lab_name=$1

#TODO: change workspace dir to something more exact
repo_dir=..

# Check for lab name
if [ -z ${lab_name} ]; then
  echo "Please supply a lab name"
  echo "Usage: start.sh [lab name]"
  exit 1
fi

# check for lab directory
if [ ! -d $lab_name ]; then
  echo "Lab \"$lab_name\" not found."
  echo "Missing directory starting-points/$lab_name"
  exit 1
fi

echo "Will deploy lab $lab_name"
echo "Notice: this will replace any pre-existing files and kubernetes objects"


# Copy workspace contents
set -ex
mkdir -p $repo_dir/workspace/
rsync -a --delete $lab_name/workspace/ $repo_dir/workspace/
set +ex

# Deploy kubernetes objects
set -e
if [ -r $lab_name/objects.yaml ]; then
  set +e
  kubectl delete -f $lab_name/objects.yaml
  set -e
  kubectl apply -f $lab_name/objects.yaml
else
  echo "No Kubernetes objects to create"
fi
set +e
