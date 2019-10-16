#!/bin/sh

cd `dirname "$0"`
lab_name=$1

#todo: change workspace dir to something more exact
repo_dir=../

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

# show output and fail on errors
set -ex

ls

# Copy workspace contents
rm -rf $repo_dir/workspace
cp -rf $lab_name/workspace $repo_dir/

# Deploy kubernetes objects
if [ -r $lab_name/objects.yaml ]; then
  kubectl delete -f $lab_name/objects.yaml
  kubectl create -f $lab_name/objects.yaml
fi
